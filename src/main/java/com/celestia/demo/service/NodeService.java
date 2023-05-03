package com.celestia.demo.service;

import com.alibaba.fastjson2.JSONObject;
import com.celestia.demo.constant.Constant;
import com.celestia.demo.data.SubmitRequest;
import com.celestia.demo.utils.HexUtils;
import com.celestia.demo.utils.HttpUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class NodeService {

    public String getBalance() {
        try {
            String resp = HttpUtils.get(Constant.BALANCE_PATH);
            JSONObject jsonObject = JSONObject.parseObject(resp);
            String amount = jsonObject.getString("amount");
            return String.valueOf(NumberUtils.toDouble(amount) / 1000000);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public JSONObject submit(SubmitRequest request) {
        JSONObject data = JSONObject.of(
                "gas_limit", NumberUtils.toLong(request.getGasLimit()),
                "fee", NumberUtils.toLong(request.getGasFee()),
                "data", HexUtils.generateRandMessage(request.getData()),
                "namespace_id", request.getNameSpaceId()
                );
        try {
            String resp = HttpUtils.post(Constant.SUBMIT_PATH, data.toString());
            return JSONObject.parseObject(resp);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
