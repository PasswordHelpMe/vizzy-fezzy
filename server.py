#!/usr/bin/env python3
"""
Simple HTTP server for Vizio TV Controller Web App
Usage: python server.py [port]
"""

import http.server
import socketserver
import sys
import os
from pathlib import Path

def main():
    # Default port
    port = 8080
    
    # Get port from command line argument
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print("Error: Port must be a number")
            sys.exit(1)
    
    # Change to the directory containing this script
    script_dir = Path(__file__).parent
    os.chdir(script_dir)
    
    # Create server
    handler = http.server.SimpleHTTPRequestHandler
    
    # Add CORS headers for development
    class CORSRequestHandler(handler):
        def end_headers(self):
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
            self.send_header('Access-Control-Allow-Headers', 'Content-Type')
            super().end_headers()
    
    try:
        with socketserver.TCPServer(("", port), CORSRequestHandler) as httpd:
            print(f"🚀 Vizio TV Controller Web App")
            print(f"📱 Server running at: http://localhost:{port}")
            print(f"🌐 Network access: http://[YOUR_IP]:{port}")
            print(f"📁 Serving files from: {script_dir}")
            print(f"⏹️  Press Ctrl+C to stop the server")
            print("-" * 50)
            
            # Get local IP address
            import socket
            try:
                hostname = socket.gethostname()
                local_ip = socket.gethostbyname(hostname)
                print(f"💡 Network URL: http://{local_ip}:{port}")
            except:
                print("💡 Unable to determine local IP address")
            
            print("-" * 50)
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print("\n👋 Server stopped")
    except OSError as e:
        if e.errno == 48:  # Address already in use
            print(f"❌ Error: Port {port} is already in use")
            print(f"💡 Try a different port: python server.py {port + 1}")
        else:
            print(f"❌ Error: {e}")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

if __name__ == "__main__":
    main() 