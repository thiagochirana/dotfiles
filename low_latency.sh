#!/usr/bin/env bash
# ⚡ Low Latency Mode temporário para jogos ⚡

IFACE=$(ip route | grep default | awk '{print $5}')

function enable() {
  echo "🔧 Ativando modo low latency..."
  sudo ethtool -K "$IFACE" tso off gso off gro off 2>/dev/null
  sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
  sudo sysctl -w net.core.default_qdisc=fq
  sudo sysctl -w net.ipv4.tcp_fastopen=3
  sudo sysctl -w net.ipv4.tcp_low_latency=1
  sudo sysctl -w net.core.rmem_max=2500000
  sudo sysctl -w net.core.wmem_max=2500000
  sudo sysctl -w net.ipv4.tcp_rmem="4096 87380 2500000"
  sudo sysctl -w net.ipv4.tcp_wmem="4096 65536 2500000"
  sudo cpupower frequency-set -g performance
  sudo tc qdisc replace dev "$IFACE" root cake bandwidth 100mbit besteffort
  echo "✅ Low latency ativado!"
}

function disable() {
  echo "🔧 Desativando low latency..."
  sudo tc qdisc del dev "$IFACE" root 2>/dev/null
  sudo cpupower frequency-set -g schedutil
  sudo sysctl -w net.ipv4.tcp_congestion_control=cubic
  sudo sysctl -w net.core.default_qdisc=fq_codel
  echo "✅ Sistema restaurado ao padrão!"
}

if [[ $1 == "--off" ]]; then
  disable
else
  enable
fi
