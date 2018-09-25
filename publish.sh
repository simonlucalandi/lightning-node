NAME=bitcoind
ACCOUNT=793603699189
docker build . -t $NAME
CO=$(aws ecr get-login --region eu-west-1 --no-include-email) && $CO
docker tag $NAME $ACCOUNT.dkr.ecr.eu-west-1.amazonaws.com/$NAME:latest &&
docker push $ACCOUNT.dkr.ecr.eu-west-1.amazonaws.com/$NAME:latest
