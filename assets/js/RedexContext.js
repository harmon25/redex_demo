import { createContext, useContext, useEffect } from "react";

export const REDEX_CONTEXT = createContext(null);

export const useRedex = () => {
  return useContext(REDEX_CONTEXT);
};

export const RedexProvider = ({ redex, children }) => {
  return (
    <REDEX_CONTEXT.Provider value={{ redex }}>
      {children}
    </REDEX_CONTEXT.Provider>
  );
};


// export const useRedexSelector(selector = (state)=>(state)){




// }