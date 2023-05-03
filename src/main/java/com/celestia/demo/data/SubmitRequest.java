package com.celestia.demo.data;

import lombok.Data;

@Data
public class SubmitRequest {

    private String nameSpaceId;

    private String data;

    private String gasLimit;

    private String gasFee;
}
