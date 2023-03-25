#!/bin/sh
echo "Channel Actions Bot - Installer."
echo "This script will install the bot and all its dependencies, and use pm2 to create a process to run the bot."

echo "Updating system.."
apt-get update
apt-get upgrade -y 

echo "Installing dependencies.."
apt install unzip npm -y
curl -fsSL https://deno.land/x/install/install.sh | sh

echo "Cloning the repository.."
git clone https://github.com/xditya/ChannelActionsBot
cd ChannelActionsBot

echo "Making a .env file.."
read -p "6038111030:AAE9Pj3WsBoK_0EXk6lrZxMMmZhxrDS_MiE" token
read -p "1524009793 5472888653" owners
read -p "mongodb+srv://Tyler:Umahpeters@cluster0.rtuol8u.mongodb.net/?retryWrites=true&w=majority" dburl

# https://stackoverflow.com/a/13633682/15249128
cat > .env << EOF
BOT_TOKEN=$token
OWNERS=$owners
MONGO_URL=$dburl
EOF

echo "Installing pm2.."
npm install pm2 --location=global

echo "Starting the bot.."
if [ "$EUID" -ne 0 ]
then
  path="/home/$(whoami)/.deno/bin/deno"
else
    path="/root/.deno/bin/deno"
fi

pm2 start main.ts --interpreter=$path --interpreter-args="run --allow-env --allow-net --allow-read --no-prompt" --name "ChannelActions" -- --polling

echo "Bot has started. View logs using 'pm2 logs ChannelActions'"
echo ""
echo "Join @BotzHub <https://TylerBotz.t.me> for more bots."
echo "Know more: https://t.me/TylerMoviesEmpire"
echo "Thanks for using TME Auto Accept Request Bot!"
