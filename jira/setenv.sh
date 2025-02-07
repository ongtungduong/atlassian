JVM_MINIMUM_MEMORY=${JVM_MINIMUM_MEMORY:-2g}
JVM_MAXIMUM_MEMORY=${JVM_MAXIMUM_MEMORY:-4g}
JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=256m -XX:ReservedCodeCacheSize=1g'

MIN_NOFILES_LIMIT=16384

JVM_SUPPORT_RECOMMENDED_ARGS=""
JVM_GC_ARGS="-XX:+ExplicitGCInvokesConcurrent"
JVM_REQUIRED_ARGS='-Dlog4j2.contextSelector=org.apache.logging.log4j.core.selector.BasicContextSelector -Dlog4j2.disableJmx=true -Dlog4j2.garbagefree.threadContextMap=true -Dlog4j2.isWebapp=false -Djava.awt.headless=true -Datlassian.standalone=JIRA -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Dorg.dom4j.factory=com.atlassian.core.xml.InterningDocumentFactory'
JVM_EXTRA_ARGS="-XX:-OmitStackTraceInFastThrow -Djava.locale.providers=COMPAT"

CURRENT_NOFILES_LIMIT=$( ulimit -Hn )
ulimit -Sn $CURRENT_NOFILES_LIMIT
ulimit -n $(( CURRENT_NOFILES_LIMIT > MIN_NOFILES_LIMIT  ? CURRENT_NOFILES_LIMIT : MIN_NOFILES_LIMIT ))

PRGDIR=`dirname "$0"`
cat "${PRGDIR}"/jirabanner.txt

JIRA_HOME_MINUSD=""
if [ "$JIRA_HOME" != "" ]; then
    echo $JIRA_HOME | grep -q " "
    if [ $? -eq 0 ]; then
	    echo ""
	    echo "--------------------------------------------------------------------------------------------------------------------"
		echo "   WARNING : You cannot have a JIRA_HOME environment variable set with spaces in it.  This variable is being ignored"
	    echo "--------------------------------------------------------------------------------------------------------------------"
    else
		JIRA_HOME_MINUSD=-Djira.home=$JIRA_HOME
    fi
fi

# DO NOT remove the following line
# !INSTALLER SET JAVA_HOME

JAVA_OPTS="-Xms${JVM_MINIMUM_MEMORY} -Xmx${JVM_MAXIMUM_MEMORY} ${JVM_CODE_CACHE_ARGS} ${JAVA_OPTS} ${JVM_REQUIRED_ARGS} ${DISABLE_NOTIFICATIONS} ${JVM_SUPPORT_RECOMMENDED_ARGS} ${JVM_EXTRA_ARGS} ${JIRA_HOME_MINUSD} ${START_JIRA_JAVA_OPTS}"

j_ver=`echo "$($JAVA_HOME/bin/java -version 2>&1)" | grep "version" | awk '{ print substr($3, 2, length($3)-2); }'`
IFS='.' read -a j_ver_parts <<< "$j_ver"

if [[ ${j_ver_parts[0]} = 17 ]]; then
  JVM_OPENS=$(cat $PRGDIR/java-opens.txt)
  JAVA_OPTS="$JVM_OPENS $JAVA_OPTS"
fi

export JAVA_OPTS

echo ""
echo "If you encounter issues starting or stopping Jira, please see the Troubleshooting guide at https://docs.atlassian.com/jira/jadm-docs-0914/Troubleshooting+installation"
echo ""
if [ "$JIRA_HOME_MINUSD" != "" ]; then
    echo "Using JIRA_HOME:       $JIRA_HOME"
fi

# set the location of the pid file
if [ -z "$CATALINA_PID" ] ; then
    if [ -n "$CATALINA_BASE" ] ; then
        CATALINA_PID="$CATALINA_BASE"/work/catalina.pid
    elif [ -n "$CATALINA_HOME" ] ; then
        CATALINA_PID="$CATALINA_HOME"/work/catalina.pid
    fi
fi
export CATALINA_PID

if [ -z "$CATALINA_BASE" ]; then
  if [ -z "$CATALINA_HOME" ]; then
    LOGBASE=$PRGDIR
    LOGTAIL=..
  else
    LOGBASE=$CATALINA_HOME
    LOGTAIL=.
  fi
else
  LOGBASE=$CATALINA_BASE
  LOGTAIL=.
fi

PUSHED_DIR=`pwd`
cd $LOGBASE
cd $LOGTAIL
LOGBASEABS=`pwd`
cd $PUSHED_DIR

echo ""
echo "Server startup logs are located in $LOGBASEABS/logs/catalina.out"