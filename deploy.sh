docker build -t fstien/multi-client: latest -t fstien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fstien/multi-server -t fstien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fstien/multi-worker -t fstien/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fstien/multi-client:latest
docker push fstien/multi-server:latest
docker push fstien/multi-worker:latest

docker push fstien/multi-client:$SHA
docker push fstien/multi-server:$SHA
docker push fstien/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=fstien/multi-client:$SHA
kubectl set image deployments/server-deployment server=fstien/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=fstien/multi-worker:$SHA

