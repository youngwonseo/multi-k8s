docker build -t youngwonseo/multi-client:latest -t youngwonseo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t youngwonseo/multi-server:latest -t youngwonseo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t youngwonseo/multi-worker:latest -t youngwonseo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push youngwonseo/multi-client:latest
docker push youngwonseo/multi-server:latest
docker push youngwonseo/multi-worker:latest

docker push youngwonseo/multi-client:$SHA
docker push youngwonseo/multi-server:$SHA
docker push youngwonseo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=youngwonseo/multi-server:$SHA
kubectl set image deployments/client-deployment client=youngwonseo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=youngwonseo/multi-worker:$SHA
