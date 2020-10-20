import { applyPatch, deepClone } from "fast-json-patch";

// just like a redux store - should only be one instance of Redex on a page...
export class Redex extends EventTarget {
  constructor({ Socket, token = "", defaultState = {} }) {
    // represents the 'view' into the server state - is what the patches are applied against...
    super();
    this.state = defaultState;
    this.changeEvt = new Event("change", { cancelable: true });
    this.channelPrefix = "__redex";
    this.socket = new Socket("/redex", { params: { token } });
    this.socket.connect();
    this.__initChannel(token);
  }

  __initChannel(token) {
    this.channel = this.socket.channel(`${this.channelPrefix}:${token}`, {
      token,
    });
    this.channel.join().receive("ok", this.__onJoin.bind(this));
    this.channel.on("diff", this.__onDiff.bind(this));
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
  }

  getState() {
    return this.state;
  }

  dispatch(action) {
    this.channel.push("dispatch", action);
  }
}
