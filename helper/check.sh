export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export TCP_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')


for i in {1..10}; do \
  kubectl exec "$(kubectl get pod -l app=sleep -n pedro-staging -o jsonpath={.items..metadata.name})" \
    -c sleep -n pedro-staging -- sh -c "(date; sleep 1) | nc $INGRESS_HOST $TCP_INGRESS_PORT"; \
done