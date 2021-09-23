docker build -t franciscogroppo/multi-client:latest -t franciscogroppo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t franciscogroppo/multi-server:latest -t franciscogroppo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t franciscogroppo/multi-worker:latest -t franciscogroppo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push franciscogroppo/multi-client:latest
docker push franciscogroppo/multi-server:latest
docker push franciscogroppo/multi-worker:latest

docker push franciscogroppo/multi-client:$SHA
docker push franciscogroppo/multi-server:$SHA
docker push franciscogroppo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=franciscogroppo/multi-server:$SHA
kubectl set image deployments/client-deployment client=franciscogroppo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=franciscogroppo/multi-worker:$SHA