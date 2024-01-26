set -o pipefail

NAME=$(terraform output -raw mig_name)
REGION=$(terraform output -raw region)
gcloud compute instance-groups managed resize $NAME --size=$1  --region=$REGION
#sleep 5
#gcloud compute instance-groups managed resize $NAME --size=  --region=$REGION
