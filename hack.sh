case "${1:-}" in
i)
  helm install cdi .
  ;;
u)
  helm uninstall cdi
  ;;
t)
  helm template .
  ;;
*)
  echo "usage:" >&2
  echo "  $0 i install" >&2
  echo "  $0 u uninstall" >&2
  echo "  $0 t template" >&2
  ;;
esac
