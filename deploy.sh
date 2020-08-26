docker build -t willgray/multi-client:latest -t willgray/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t willgray/multi-server:latest -t willgray/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t willgray/multi-worker:latest -t willgray/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push willgray/multi-client:latest
docker push willgray/multi-server:latest
docker push willgray/multi-worker:latest

docker push willgray/multi-client:$SHA
docker push willgray/multi-server:$SHA
docker push willgray/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=willgray/multi-server:$SHA
kubectl set image deployments/client-deployment client=willgray/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=willgray/multi-worker:$SHA