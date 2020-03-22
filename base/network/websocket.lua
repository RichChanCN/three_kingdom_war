local rpc = {}

function rpc:some()
    self.wsSendText = cc.WebSocket:create("ws://konnichiwa.us:2019") 
    local receiveTextTimes = 0
    local function wsSendTextOpen(strData) 
        cclog("Send Text WS was opened.") 
        self.wsSendText:sendString("Hello WebSocket中文, I'm a text message.") 
    end 
      
    local function wsSendTextMessage(strData) 
        receiveTextTimes = receiveTextTimes + 1 
        local strInfo= "response text msg: "..strData..", "..receiveTextTimes     
        cclog(strInfo) 
    end 
      
    local function wsSendTextClose(strData) 
        cclog("_wsiSendText websocket instance closed.") 
        self.wsSendText = nil 
    end 

    local function wsSendTextError(strData) 
        print("sendText Error was fired") 
    end 

    if nil ~= self.wsSendText then 
        self.wsSendText:registerScriptHandler(wsSendTextOpen,cc.WEBSOCKET_OPEN) 
        self.wsSendText:registerScriptHandler(wsSendTextMessage,cc.WEBSOCKET_MESSAGE) 
        self.wsSendText:registerScriptHandler(wsSendTextClose,cc.WEBSOCKET_CLOSE) 
        self.wsSendText:registerScriptHandler(wsSendTextError,cc.WEBSOCKET_ERROR) 
    end
end