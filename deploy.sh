docker build -t xxdpavelxx/multi-client:latest -t xxdpavelxx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xxdpavelxx/multi-server:latest -t xxdpavelxx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xxdpavelxx/multi-worker:latest -t xxdpavelxx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xxdpavelxx/multi-client:latest
docker push xxdpavelxx/multi-server:latest
docker push xxdpavelxx/multi-worker:latest

docker push xxdpavelxx/multi-client:$SHA
docker push xxdpavelxx/multi-server:$SHA
docker push xxdpavelxx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xxdpavelxx/multi-server:$SHA
kubectl set image deployments/client-deployment client=xxdpavelxx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xxdpavelxx/multi-worker:$SHA
