
# This function allows you to tunnel into an ODE pod using information
# you provide from the houston environment. Namespace and Pod Name.
# It will prompt for VPN/AWS status, then either use provided parameters or prompt for pod name and namespace
# @param $1 pod_name (optional)
# @param $2 namespace (optional)
ode_terminal() {
  # Prompt for VPN status
  echo "Are you logged into AWS and on VPN? (y/n)"
  read -r vpn_response

  if [[ "$vpn_response" != "y" && "$vpn_response" != "Y" ]]; then
    echo "Please log into AWS and connect to VPN first."
    return 1
  fi

  local pod_name="$1"
  local namespace="$2"

  if [[ -z "$pod_name" ]]; then
    echo "Enter pod name:"
    read -r pod_name

    if [[ -z "$pod_name" ]]; then
      echo "Error: Pod name cannot be empty"
      return 1
    fi
  fi

  if [[ -z "$namespace" ]]; then
    echo "Enter namespace:"
    read -r namespace

    if [[ -z "$namespace" ]]; then
      echo "Error: Namespace cannot be empty"
      return 1
    fi
  fi

  echo "Tunneling into $pod_name in the environment $namespace"
  kubectl exec -it "$pod_name" -n "$namespace" -- bash
}

# Keep MacBook awake for specified hours (1-12)
# @param $1 hours (1-12), defaults to 1 hour if not provided
stay_awake() {
  local hours=${1:-1}  # Default to 1 hour if no argument provided

  # Validate input is between 1 and 12
  if [[ $hours -lt 1 || $hours -gt 12 ]]; then
    return 1
  fi

  # Convert hours to seconds (hours * 3600)
  local duration=$((hours * 3600))

  echo "🔓 Keeping your MacBook awake for $hours hour(s) ($duration seconds)..."
  echo "Press Ctrl+C to stop early and allow normal sleep behavior"

  caffeinate -d -i -s -t $duration
}