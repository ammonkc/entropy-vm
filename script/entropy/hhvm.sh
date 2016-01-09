#!/bin/bash -eux

if [[ $HHVM  =~ true || $HHVM =~ 1 || $HHVM =~ yes ]]; then
echo "==> Installing HHVM"
yum --nogpgcheck --enablerepo=remi,remi-php56 -y install hhvm

cat << 'EOF' > /etc/rc.d/init.d/hhvm
#!/bin/bash

# Source function library.
. /etc/rc.d/init.d/functions
# Default values. This values can be overwritten in
CONFIG_FILE="/etc/hhvm/daemon.hdf"
SYSTEM_CONFIG_FILE="/etc/hhvm/php.ini"
RUN_AS_USER="apache"
RUN_AS_GROUP="apache"
ADDITIONAL_ARGS=""

hhvm=/usr/bin/hhvm
prog=$(/bin/basename $hhvm)
lockfile=/var/lock/subsys/hhvm
PIDFILE=/var/run/hhvm/pid
RETVAL=0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

DAEMON_ARGS="--config ${SYSTEM_CONFIG_FILE} \
--config ${CONFIG_FILE} \
--user ${RUN_AS_USER} \
--mode daemon \
-vPidFile=${PIDFILE} \
${ADDITIONAL_ARGS}"

test -x /usr/bin/hhvm || exit 1

start() {
    echo -n $"Starting $prog: "
    touch $PIDFILE
    chown $RUN_AS_USER:$RUN_AS_GROUP $PIDFILE
    daemon --pidfile ${PIDFILE} ${hhvm} --config ${SYSTEM_CONFIG_FILE} --config ${CONFIG_FILE} --mode daemon
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}

stop() {
    echo -n $"Stopping $prog: "
    killproc -p ${PIDFILE} ${prog}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfile} ${PIDFILE}
}

rh_status() {
    status -p ${PIDFILE} ${hhvm}
}

check_run_dir() {
    # Only perform folder creation, if the PIDFILE location was not modified
    PIDFILE_BASEDIR=$(dirname ${PIDFILE})
    # We might have a tmpfs /var/run.
    if [ "/var/run/hhvm" = "${PIDFILE_BASEDIR}" ] && [ ! -d /var/run/hhvm ]; then
        mkdir -p -m0755 /var/run/hhvm
        chown $RUN_AS_USER:$RUN_AS_GROUP /var/run/hhvm
    fi
}

case "$1" in
  start)
  check_run_dir
        rh_status >/dev/null 2>&1 && exit 0
        start
        ;;
  stop)
        stop
        ;;

  reload|force-reload|restart|try-restart)
        stop
        start
        ;;

  status)
        rh_status
        RETVAL=$?
        ;;

  *)
        echo "Usage: /etc/init.d/hhvm {start|stop|restart|status}"
        exit 2
esac

exit $RETVAL
EOF

cat << 'EOF' > /etc/hhvm/daemon.hdf
PidFile = /var/run/hhvm/pid

Server {
  Port = 9001
  Type = fastcgi
  FixPathInfo = true
  DefaultDocument = index.php
}
Log {
  Level = Warning
  AlwaysLogUnhandledExceptions = true
  RuntimeErrorReportingLevel = 8191
  UseLogFile = true
  UseSyslog = false
  File = /var/log/hhvm/error.log
  Access {
    * {
      File = /var/log/hhvm/access.log
      Format = %h %l %u % t \"%r\" %>s %b
    }
  }
}
Eval {
  Jit = true
  EnableHipHopSyntax = true
}
Repo {
  Central {
    Path = /var/log/hhvm/.hhvm.hhbc
  }
}
#include "/usr/share/hhvm/hdf/static.mime-types.hdf"
StaticFile {
  FilesMatch {
    * {
      pattern = .*\.(dll|exe)
      headers {
        * = Content-Disposition: attachment
      }
    }
  }
  Extensions : StaticMimeTypes
}
MySQL {
  TypedResults = false
}
EOF
fi
