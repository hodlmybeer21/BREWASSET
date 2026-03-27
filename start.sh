#!/bin/bash
# Start both API server and frontend dev server
set -e

# Start the backend API server in background
PORT=10000 node artifacts/api-server/dist/index.cjs &
API_PID=$!

# Start the frontend dev server in background
cd artifacts/brewasset
PORT=3000 BASE_PATH=/ node_modules/.bin/vite --host 0.0.0.0 --port 3000 &
VITE_PID=$!

# Wait for either to exit
wait $API_PID $VITE_PID
