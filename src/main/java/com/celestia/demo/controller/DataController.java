package com.celestia.demo.controller;

import com.alibaba.fastjson2.JSONObject;
import com.celestia.demo.constant.Constant;
import com.celestia.demo.data.InitData;
import com.celestia.demo.data.SubmitRequest;
import com.celestia.demo.data.SubmitResult;
import com.celestia.demo.service.NodeService;
import com.celestia.demo.utils.HexUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DataController {

    @Autowired
    private NodeService nodeService;

    @GetMapping("/getData")
    public InitData getInitData(){
        InitData initData = new InitData();
        initData.setBalance(nodeService.getBalance());
        initData.setNode(Constant.NODE);
        initData.setNameSpaceId(HexUtils.generateRandHexEncodedNamespaceID());
        return initData;
    }

    @PostMapping("/submit")
    public SubmitResult submit(@RequestBody SubmitRequest request){
        JSONObject jsonObject = nodeService.submit(request);
        return build(jsonObject, request.getNameSpaceId());
    }

    private SubmitResult build(JSONObject jsonObject, String nameSpaceId) {
        SubmitResult submitResult = new SubmitResult();
        submitResult.setHeight(jsonObject.getString("height"));
        submitResult.setTxhash(jsonObject.getString("txhash"));
        submitResult.setNameSpaceId(nameSpaceId);
        submitResult.setUrl("https://testnet.mintscan.io/celestia-incentivized-testnet/txs/" + submitResult.getTxhash());
        return submitResult;
    }
}
