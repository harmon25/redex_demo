import { applyPatch, deepClone } from "fast-json-patch";

// just like a redux store - should only be one instance of Redex on a page...
export class Redex extends EventTarget {
  constructor({ Socket, token = "", defaultState = {}, extraStores = [], onReady = (redexInstance) => {} }) {
    // represents the 'view' into the server state - is what the patches are applied against...
    super();
    this.channels = [];
    this.state = defaultState;
    this.changeEvt = new Event("change", { cancelable: true });
    this.channelPrefix = "__redex";
    this.socket = new Socket("/redex", { params: { token } });
    this.socket.connect();
    this.onReady = onReady;
    this.__initChannel(token);

    // bind to this...
    this.__onDiff.bind(this);
    this.__onJoin.bind(this);
    this.getState.bind(this);
    this.dispatch.bind(this);
  }

  __initChannel(token) {
    let channel = this.socket.channel(`${this.channelPrefix}:${token}`, {
      token,
    });
    channel.join().receive("ok", this.__onJoin.bind(this));
    channel.on("diff", this.__onDiff.bind(this));
    this.channels.push(channel)

  }

  __onDiff({ diff }) {
    const { newDocument } = applyPatch(this.state, diff);
    this.state = deepClone(newDocument);
    this.dispatchEvent(this.changeEvt);
  }

  __onJoin(resp) {
    // sets state from server after join - dispatch change event to trigger.
    this.state = resp;
    this.dispatchEvent(this.changeEvt);
    // pass this redex instance into onReady to pass 
    this.onReady(this)
  }

  getState() {
    return this.state;
  }

  dispatch(action) {
    for(let i = 0; i < this.channels.length; i ++){
      this.channels[i].push("dispatch", action);
    }
  }
}
