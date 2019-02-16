clear
echo "Cloud Tiering Demo"
read
echo "Checking vxcloudd daemon status"
read
echo "ps -eaf | grep vxcloudd"
read
ps -eaf | grep vxcloudd
read
clear
#######################################################################
clear
echo "Creating local volumes for 3 types of cloud providers"
read
echo "Creating volume to access Amazon bucket"
read
echo "/opt/VRTS/bin/vxassist -g testdg make aws-bucket 10m fscloud=on"
/opt/VRTS/bin/vxassist -g testdg make aws-bucket 10m fscloud=on
read
echo "Creating volume to access Azure bucket"
read
echo "/opt/VRTS/bin/vxassist -g testdg make azure-blob 10m fscloud=on"
read
/opt/VRTS/bin/vxassist -g testdg make azure-blob 10m fscloud=on
echo "Creating volume to access GCP bucket"
read
echo "/opt/VRTS/bin/vxassist -g testdg make gcp-bucket 10m fscloud=on"
read
/opt/VRTS/bin/vxassist -g testdg make gcp-bucket 10m fscloud=on
read
#######################################################################
clear
echo "Printing volumes"
read
vxprint
read
#######################################################################
clear
read
echo "Attaching cloud storage to above created volumes"
read
echo "Attaching aws bucket to a volume named as aws-bucket"
read
echo "vxcloud -g testdg addcloud aws-bucket host=s3.amazonaws.com bucket=fsqa-bucket2  access_key=AKIAIPPHZ3VSK4YDNF4A secret_key=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 type=S3"
read
vxcloud -g testdg addcloud aws-bucket host=s3.amazonaws.com bucket=fsqa-bucket2  access_key=AKIAIPPHZ3VSK4YDNF4A secret_key=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 type=S3
echo "Attaching Azure blob to a volume named as azure-blob"
read
echo "vxcloud -g testdg addcloud azure-blob host=vxfsaccounthot.blob.core.windows.net bucket=fsqa-blob2 access_key=5ZMZlU3ZX1ujjh+NcFomaEo8qq/pbs3kGcO4hV2ldOxEMvC+kkM9VEwWScojT00SYwfspmamridedu6kAPj4sw== endpoint=vxfsaccounthot type=BLOB https=false"  
read
vxcloud -g testdg addcloud azure-blob host=vxfsaccounthot.blob.core.windows.net bucket=fsqa-blob2 access_key=5ZMZlU3ZX1ujjh+NcFomaEo8qq/pbs3kGcO4hV2ldOxEMvC+kkM9VEwWScojT00SYwfspmamridedu6kAPj4sw== endpoint=vxfsaccounthot type=BLOB https=false

echo "Attaching gcp bucket to a volume named as gcp-bucket"
read
echo "vxcloud -g testdg addcloud gcp-bucket host=infoscale-bucket.storage.googleapis.com bucket=fsqabucket2 type=GOOGLE google_config=/cloud-config/infoscale-196005-67138e94d782.json https=true"
read
vxcloud -g testdg addcloud gcp-bucket host=infoscale-bucket.storage.googleapis.com bucket=fsqabucket2 type=GOOGLE google_config=/cloud-config/infoscale-196005-67138e94d782.json https=true
echo "Listing cloud details"
read
echo "vxcloud -g testdg listcloud"
read
vxcloud -g testdg listcloud
read
#######################################################################
clear
read
echo "Creating vset using  above volumes"
read
echo "vxvset -g testdg make vset vol1"
read
vxvset -g testdg make vset vol1
read
echo "vxvset -g testdg addvol vset aws-bucket"
read
vxvset -g testdg addvol vset aws-bucket
read
echo "vxvset -g testdg addvol vset azure-blob"
read
vxvset -g testdg addvol vset azure-blob
read
echo "vxvset -g testdg addvol vset gcp-bucket"
read
vxvset -g testdg addvol vset gcp-bucket
read
#######################################################################
clear
echo "Printing volumes"
read
vxprint
read
#######################################################################
clear
echo "Setting tags for each volume"
read
echo "/opt/VRTS/bin/vxassist -g testdg settag vol1 vxfs.placement_class.tier1"
read
/opt/VRTS/bin/vxassist -g testdg settag vol1 vxfs.placement_class.tier1
read
echo "/opt/VRTS/bin/vxassist -g testdg settag aws-bucket vxfs.placement_class.tier2"
read
/opt/VRTS/bin/vxassist -g testdg settag aws-bucket vxfs.placement_class.tier2
read
echo "/opt/VRTS/bin/vxassist -g testdg settag azure-blob vxfs.placement_class.tier3"
read
/opt/VRTS/bin/vxassist -g testdg settag azure-blob vxfs.placement_class.tier3
read
echo "/opt/VRTS/bin/vxassist -g testdg settag gcp-bucket vxfs.placement_class.tier4"
read
/opt/VRTS/bin/vxassist -g testdg settag gcp-bucket vxfs.placement_class.tier4
read
echo "Listing tags of each volume"
read
echo "/opt/VRTS/bin/vxassist -g testdg listtag"
read
/opt/VRTS/bin/vxassist -g testdg listtag
read
#######################################################################
clear
echo "Creating vxfs file system and mounting it on /mnt1 mount point"
read
echo "/opt/VRTS/bin/mkfs -t vxfs /dev/vx/dsk/testdg/vset"
read
/opt/VRTS/bin/mkfs -t vxfs /dev/vx/dsk/testdg/vset
read
echo "/opt/VRTS/bin/mount -t vxfs /dev/vx/dsk/testdg/vset /mnt1"
read
/opt/VRTS/bin/mount -t vxfs /dev/vx/dsk/testdg/vset /mnt1
read
df -h | grep /mnt1
read
#######################################################################
clear
echo "Assigning policy"
read
echo "Displaying policy"
read
echo "/opt/VRTS/bin/fsppadm  assign /mnt1 /cloud-config/cloud_file_tiering_write_policy.xml"
read
/opt/VRTS/bin/fsppadm  assign /mnt1 /cloud-config/cloud_file_tiering_write_policy.xml
read
echo "List assigned policy"
read
echo "/opt/VRTS/bin/fsppadm  list /mnt1"
read
/opt/VRTS/bin/fsppadm  list /mnt1
read
echo "Create file for demo"
read
echo "for i in {1..5}; do dd if=/dev/urandom of=/mnt1/file-$i bs=8192 count=$i; done"
read
for i in {1..5}; do dd if=/dev/urandom of=/mnt1/file-$i bs=8192 count=$i; done
read
echo "Executing query to check file movement"
read
echo "/opt/VRTS/bin/fsppadm query /mnt1"
read
/opt/VRTS/bin/fsppadm query /mnt1
read
echo "Taking cksum of files when they are on Tier1"
read
echo "cksum /mnt1/file-* > /on-prime-cksum"
read
cksum /mnt1/file-* > /on-prime-cksum
read
cat /on-prime-cksum
read
echo "Enforcing policy to move files from Tier1 to Tier2"
read
read
read
echo "/opt/VRTS/bin/fsppadm enforce /mnt1"
read
/opt/VRTS/bin/fsppadm enforce /mnt1

read
echo "Check status of files on AWS"
read
sleep 10
#######################################################################
read
/opt/VRTS/bin/fsppadm query /mnt1
read
echo "Enforcing policy to move files from Tier2 to Tier3"
read
echo "/opt/VRTS/bin/fsppadm enforce /mnt1"
read
/opt/VRTS/bin/fsppadm enforce /mnt1
read
echo "Check status of files on Azure"
read
/opt/VRTS/bin/fsppadm query /mnt1
read
echo "Enforcing policy to move files from Tier3 to Tier4"
read
echo "/opt/VRTS/bin/fsppadm enforce /mnt1"
read
/opt/VRTS/bin/fsppadm enforce /mnt1
read
echo "Check status of files on GCP"
sleep 15
read
echo "Taking cksum of files when they are on Tier4"
read
echo "cksum /mnt1/file-* > /tier4-cksum"
read
cksum /mnt1/file-* > /tier4-cksum
read
cat /tier4-cksum
read
echo "Comparing cksum of files wither they were on Tier1 and when they are on Tier4"
read
diff /on-prime-cksum  /tier4-cksum
clear
read
echo "Bringing back files from cloud to on-premises"
read
echo "Assigning policy"
read
echo "/opt/VRTS/bin/fsppadm  assign /mnt1 /cloud-config/cloud_file_tiering_read_policy.xml"
read
/opt/VRTS/bin/fsppadm  assign /mnt1 /cloud-config/cloud_file_tiering_read_policy.xml
sleep 5
read
echo "List assigned policy"
read
echo "/opt/VRTS/bin/fsppadm  list /mnt1"
read
/opt/VRTS/bin/fsppadm  list /mnt1
read
echo "Executing query to check file movement"
read
echo "/opt/VRTS/bin/fsppadm query /mnt1"
read
/opt/VRTS/bin/fsppadm query /mnt1
read
echo "Enforcing policy to move files from Tier4 to Tier1"
read
echo "/opt/VRTS/bin/fsppadm enforce /mnt1"
read
/opt/VRTS/bin/fsppadm enforce /mnt1
read
echo "Listing file status"
read
sleep 10
echo "/opt/VRTS/bin/fsppadm query /mnt1"
read
/opt/VRTS/bin/fsppadm query /mnt1
read
echo "Taking cksum of files when they are back to Tier1"
read
echo "cksum /mnt1/file-* > /back-to-prime-cksum"
read
cksum /mnt1/file-* > /back-to-prime-cksum
read
cat /back-to-prime-cksum
read
echo "Comparing cksum of files before cloud movement and after cloud movement"
read
diff /on-prime-cksum  /back-to-prime-cksum
read
#######################################################################
clear
read
echo "Check status of files on cloud"
read
echo "######DEMO COMPLETED######"





