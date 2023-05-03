package com.celestia.demo.utils;

import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;

public class HexUtils {

    private static SecureRandom random = new SecureRandom();

    static {
        random.setSeed(888888);
    }
    private static final char[] HEX_ARRAY = "0123456789ABCDEF".toCharArray();
    public static String generateRandHexEncodedNamespaceID() {
        byte[] nID = new byte[8];
        random.nextBytes(nID);
        return bytesToHex(nID);
    }

    public static String generateRandMessage(String data) {
        try {
            return bytesToHex(data.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    private static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int i = 0; i < bytes.length; i++) {
            int v = bytes[i] & 0xFF;
            hexChars[i * 2] = HEX_ARRAY[v >>> 4];
            hexChars[i * 2 + 1] = HEX_ARRAY[v & 0x0F];
        }
        return new String(hexChars);
    }
}
