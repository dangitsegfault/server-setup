FROM alpine:latest

# Install only the absolute essentials: WireGuard, routing tools, and iptables
RUN apk add --no-cache wireguard-tools iptables iproute2

# Create the configuration directory
RUN mkdir -p /etc/wireguard

# Add a simple startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the default command
ENTRYPOINT ["/entrypoint.sh"]
