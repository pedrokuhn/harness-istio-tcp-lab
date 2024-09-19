export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

for i in {1..10}; do curl http://$INGRESS_HOST/anything; done
