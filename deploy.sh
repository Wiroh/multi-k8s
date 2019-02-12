docker build -t samuelsciascia/multi-client:latest -t samuelsciascia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samuelsciascia/multi-server:latest -t samuelsciascia/multi-server:$SHA ./server/Dockerfile ./server
docker build -t samuelsciascia/multi-worker:latest -t samuelsciascia/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push samuelsciascia/multi-client:latest
docker push samuelsciascia/multi-server:latest
docker push samuelsciascia/multi-worker:latest

docker push samuelsciascia/multi-client:$SHA
docker push samuelsciascia/multi-server:$SHA
docker push samuelsciascia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=samuelsciascia/multi-client:$SHA
kubectl set image deployments/server-deployment server=samuelsciascia/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=samuelsciascia/multi-worker:$SHA