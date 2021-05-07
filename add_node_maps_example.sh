#!/bin/bash

PARTNER="example-mds1"
if [ "$(uname -n)" != "example-mds2" ] ; then
	echo "Run on example-mds2"
	exit 1
fi
. add_node_maps_shared

declare -A DIR
DIR['lustre_example01_01']="/example01"
DIR['lustre_example01_02']="/example01/mdt0/lustre_example01_02"
DIR['lustre_example01_03']="/example01/mdt1/lustre_example01_03"

DIR['lustre_example02_01']="/example02/mdt2/lustre_example02_01"

DIR['lustre_example03_01']="/example03/mdt3/lustre_example03_01"

declare -A EXT_UID
EXT_UID['lustre_example01_01']="51210" # lustre_example01_01
EXT_UID['lustre_example01_02']="51211" # lustre_example01_02
EXT_UID['lustre_example01_03']="51212" # lustre_example01_03
EXT_UID['lustre_example02_01']="51213" # lustre_example02_01
EXT_UID['lustre_example03_01']="51214" # lustre_example03_01


declare -A EXT_GID
# Note the space here changes the way the groups are done
EXT_GID['lustre_example01_01']="2220:2220 2221:2221 2222:2222"
EXT_GID['lustre_example01_02']="2221" # lustre_example01_02
EXT_GID['lustre_example01_03']="2222" # lustre_example01_03
EXT_GID['lustre_example02_01']="2223" # lustre_example02_01
EXT_GID['lustre_example03_01']="2224" # lustre_example03_01

declare -A TRUSTED_ADMIN
declare -A TRUSTED_TENANT
declare -A DENY_UNKNOWN

for i in changeme
do
  check_project
  DENY="${DENY_UNKNOWN[$i]:=0}" TRUSTED="${TRUSTED_TENANT[$i]:=0}" ADMIN="${TRUSTED_ADMIN[$i]:=0}" TENANT_NAME="${i}" TENANT_DIR="${DIR[$i]}" TENANT_RANGE="${RANGE[$i]}" EXT_U="${EXT_UID[$i]}" EXT_G="${EXT_GID[$i]}" create_nodemap
done
