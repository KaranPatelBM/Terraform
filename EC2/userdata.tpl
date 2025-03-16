#!/bin/bash
sudo apt update -y
sudo apt install -y nodejs npm git
npm install -g pm2

git clone ${Music_Discovery_repo_url} /home/ubuntu/react-app
cd /home/ubuntu/react-app
npm install
npm run build
pm2 start npm --name react-app -- start --port ${react_port}

git clone ${Music_Discovery_playwright_repo_url} /home/ubuntu/playwright-tests
cd /home/ubuntu/playwright-tests
npm install
npx playwright install