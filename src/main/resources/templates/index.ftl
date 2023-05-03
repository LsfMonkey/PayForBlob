<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PayForBlob</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body,html {
            margin: 0;
            width: 100%;
            height: 100%;
        }
        .container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .header {
            width: 100%;
            height: 50px;
            text-align: center;
            font-size: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 60px;
        }
        .content {
            margin: 0 auto;
            width: 855px;
            position: relative;
        }
        .content-tips {
            margin-bottom: 25px;
            display: flex;
        }
        .content-tips_item {
            flex: 1;
            min-width: 0;
        }
        .content-tips_item + .content-tips_item {
            margin-left: 10px;
        }
        .content-tips_item .label{
            font-weight: bold;
            font-size: 20px;
        }

        .form-container {
            width: 855px;
            display: flex;
            flex-wrap: wrap;
        }
        .form-item {
            position: relative;
            width: 410px;
            height: 60px;
            margin-bottom: 15px;
            margin-right: 15px;
            padding: 12px 4px 15px;
            color: #000000d9;
            font-size: 14px;
            line-height: 1.5715;
            background-color: #fff;
            background-image: none;
            border: 1px solid #d9d9d9;
            border-radius: 2px;
            transition: all .3s;
            box-sizing: border-box;
        }
        .form-item span {
            position: absolute;
            top: -15px;
            font-weight: bold;
            font-size: 20px;
        }
        .form-item input, .form-item textarea {
            margin: 0;
            font-variant: tabular-nums;
            list-style: none;
            font-feature-settings: "tnum";
            position: relative;
            display: inline-block;
            width: 100%;
            min-width: 0;
            border: 0;
            height: 100%;
        }
        .form-item textarea {
            resize:none;
        }
        .form-item input:focus, .form-item input:active, .form-item input:focus-visible {
            border: none;
            outline: none;
        }
        .form-item textarea:focus, .form-item textarea:active, .form-item textarea:focus-visible {
            border: none;
            outline: none;
        }
        .content-op {
            width: 100%;
            display: flex;
            justify-content: center;
        }
        .content-op button {
            width: 135px;
            line-height: 1.5715;
            position: relative;
            display: inline-block;
            font-weight: 400;
            white-space: nowrap;
            text-align: center;
            cursor: pointer;
            transition: all .3s cubic-bezier(.645,.045,.355,1);
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            touch-action: manipulation;
            height: 32px;
            padding: 4px 15px;
            font-size: 14px;
            border-radius: 2px;
            border: 1px solid #1890ff;
            background: #1890ff;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0,0,0,.12);
            box-shadow: 0 2px #0000000b;
        }
        .form-item-block {
            width: 855px;
            height: 150px;
            margin-right: 0;
        }
        .content-result {
            display: inline-block;
            border: 1px solid #d9d9d9;
            border-radius: 2px;
            width: 855px;
            margin: 25px auto;
            padding: 25px;
            box-sizing: border-box;
        }
        .content-result-item {
            width: 800px;
            margin-bottom: 15px;
        }
        .content-result-item .label{
            font-weight: bold;
            font-size: 20px;
        }
        .loading {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 40px;
            height: 40px;
            z-index: 222;
        }

        .loading:before,
        .loading:after {
            position: absolute;
            width: 10px;
            height: 10px;
            content: "";
            border-radius: 100%;
            background-color: #000;
        }

        .loading:before {
            transform: translate(0, 0);
            animation: ball-circle-before infinite 1.5s linear;
        }

        .loading:after {
            transform: translate(30px, 30px);
            animation: ball-circle-after infinite 1.5s linear;
        }

        @keyframes ball-circle-after {
            0% {
                transform: translate(30px, 30px);
            }

            25% {
                transform: translate(0, 30px);
            }

            50% {
                transform: translate(0, 0);
            }

            75% {
                transform: translate(30px, 0);
            }

            100% {
                transform: translate(30px, 30px);
            }
        }

        @keyframes ball-circle-before {
            0% {
                transform: translate(0, 0);
            }

            25% {
                transform: translate(30px, 0);
            }

            50% {
                transform: translate(30px, 30px);
            }

            75% {
                transform: translate(0, 30px);
            }

            100% {
                transform: translate(0, 0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            PayForBlob
        </div>
        <div class="content">
            <div class="loading" id="myLoading" style="display: none"></div>
            <div class="content-tips">
                <div class="content-tips_item">
                    <span class="label">Namespace id:</span>
                    <span id="nameSpaceId"></span>
                </div>
                <div class="content-tips_item">
                    <span class="label">Node:</span>
                    <span id="node"></span>
                </div>
                <div class="content-tips_item">
                    <span class="label">Balance:</span>
                    <span id="balance"></span>
                </div>
            </div>
            <div class="form-container">
                <div class="form-item form-item-block">
                    <span class="label">Data</span>
                    <textarea cols="30" rows="10" id="myData"></textarea>
                </div>
                <div class="form-item">
                    <span  class="label">Gas limit</span>
                    <input type="text" id="gasLimit">
                </div>
                <div class="form-item">
                    <span  class="label">Fee</span>
                    <input type="text" id="gasFee">
                </div>
            </div>
            <div class="content-op">
                <button id="submit-btn">提交</button>
            </div>
        </div>
        <div class="content-result" id="result" style="display: none">
            <div class="content-result-item">
                <span class="label">NameSpaceId:</span>
                <span id="newNameSpaceId"></span>
            </div>
            <div class="content-result-item">
                <span class="label">Height:</span>
                <span id="height"></span>
            </div>
            <div class="content-result-item">
                <span class="label">TxHash:</span>
                <span id="txhash"></span>
            </div>
            <div class="content-result-item">
                <span class="label">Url:</span>
                <a href="" target="_blank" id="url"></a>
            </div>
        </div>
    </div>
</body>
<script>
    (function () {
        // init
        function init () {
            $.ajax({
                type: "GET",
                url: "/getData",
                success(data) {
                    if (!data) {
                        return;
                    }
                    $("#balance").text(data.balance || 0);
                    $("#nameSpaceId").text(data.nameSpaceId || '');
                    $("#node").text(data.node || '');
                    $('#gasFee').val('2000');
                    $('#gasLimit').val('80000');
                },
                error() {
                    alert('node is unavailable')
                }
            })
        }
        let loading = false;
        // submint
        $("#submit-btn").click(function() {
            if (loading) {
                return;
            }
            const data = {
                "nameSpaceId": $('#nameSpaceId').text(),
                "gasLimit": $('#gasLimit').val(),
                "gasFee": $('#gasFee').val(),
                "data": $('#myData').val(),
            };
            loading = true;
            $("#myLoading").show();
            $.ajax({
                type: "POST",
                url: "/submit",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    if (!data) {
                        return;
                    }
                    $("#result").show();
                    $("#newNameSpaceId").text(data.nameSpaceId);
                    $("#height").text(data.height);
                    $("#txhash").text(data.txhash);
                    $("#url").attr("href", data.url);
                    $("#url").text(data.url);
                    if (data.url) {
                        $("#url").show();
                    } else {
                        $("#url").hide();
                    }
                    init();
                    loading = false;
                    $("#myLoading").hide();
                },
                error: function(xhr, status, error) {
                    loading = false;
                    alert('node is unavailable');
                    $("#myLoading").hide();
                }
            });
        });

        init();
    })()
</script>
</html>