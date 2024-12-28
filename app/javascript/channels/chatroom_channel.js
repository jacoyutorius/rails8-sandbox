import consumer from "channels/consumer"

// const appChat = consumer.subscriptions.create("ChatroomChannel", {
const appChat = consumer.subscriptions.create({ channel: "ChatroomChannel", chatroom_id: 1 }, {
  connected() {
    console.log('connected');
  },

  disconnected() {
    console.log('disconnected');
  },

  received(data) {
    console.log(data);
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('afterbegin', data['message']);
  },

  talk(data) {
    console.log(data);
    return this.perform('talk', { data: data });
  }
});

document.getElementById('content').addEventListener('keyup', function (e) {
  if (e.key === 'Enter') {
    const sender = document.getElementById('sender');
    appChat.talk({sender: sender.value, content: e.target.value});
    e.target.value = '';
    e.preventDefault();
  }
});
