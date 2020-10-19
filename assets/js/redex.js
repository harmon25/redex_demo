import { applyPatch, deepClone } from "fast-json-patch";

// just like a redux store - should only be one instance of Redex on a page...
export class Redex {
  constructor({
    Socket,
    token = "",
    onChange = (newState) => {
      console.log("NEW STATE!");
      console.log(newState);
    },
  }) {
    // represents the 'view' into the server state - is what the patches are applied against...
    this.state = null;
    this.onChangeCB = onChange;
    this.channelPrefix = "__redex";
    this.socket = new Socket("/redex", { params: { token } });
    this.socket.connect();
    this.channel = this.socket.channel(`${this.channelPrefix}:${token}`, {
      token,
    });
    this.channel.join().receive("ok", this.__onJoin.bind(this));
    this.channel.on("diff", this.__onDiff.bind(this));
  }

  __onDiff({ diff }) {
    const { newDocument } = applyPatch(this.state, diff);
    this.state = deepClone(newDocument);
    this.onChangeCB(this.state);
  }

  __onJoin(resp) {
    this.state = resp;
  }

  getState() {
    return this.state;
  }

  dispatch(action) {
    this.channel.push("dispatch", action)
  }
}