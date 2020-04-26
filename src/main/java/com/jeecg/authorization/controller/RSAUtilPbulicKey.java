package com.jeecg.authorization.controller;

import org.apache.commons.net.util.Base64;
import org.springframework.stereotype.Controller;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.HashMap;
import java.util.Map;

/**
 * @program: template
 * @description: 私钥加密，公钥解密。
 * @author: cuixy
 * @create: 2020-04-24 11:03
 **/
@Controller
public class RSAUtilPbulicKey {

    public static String data = "12345";
    public static BASE64Encoder base64Encoder = new BASE64Encoder();
    public static BASE64Decoder base64Decoder = new BASE64Decoder();
    // 公钥
    private static String publicKeyStr = "";
    // 私钥
    private static String privateKeyStr = "";

    private static RSAUtilPbulicKey ourInstance = new RSAUtilPbulicKey();

    public static RSAUtilPbulicKey getInstance() {
        return ourInstance;
    }


    public static Map<String, String> getKeyPairs() throws Exception {
        KeyPair keyPair = getKeyPair();
        privateKeyStr = new String(Base64.encodeBase64(keyPair.getPrivate().getEncoded()));
        publicKeyStr = new String(Base64.encodeBase64(keyPair.getPublic().getEncoded()));
        HashMap<String, String> data = new HashMap<>();
        data.put("privateKeyStr", privateKeyStr);
        data.put("publicKeyStr", publicKeyStr);
        return data;
    }

    /**
     * 获取密钥对
     *
     * @return 密钥对
     */
    public static KeyPair getKeyPair() throws Exception {
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(1024);
        return generator.generateKeyPair();
    }


    // 生成密钥对
    private void generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator;
        keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(1024);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        // 获取公钥，并以base64格式打印出来
        PublicKey publicKey = keyPair.getPublic();
        publicKeyStr = new String(base64Encoder.encode(publicKey.getEncoded()));
        // 获取私钥，并以base64格式打印出来
        PrivateKey privateKey = keyPair.getPrivate();
        privateKeyStr = new String(base64Encoder.encode(privateKey.getEncoded()));
    }

    // 将base64编码后的公钥字符串转成PublicKey实例
    private static PublicKey getPublicKey(String publicKey) throws Exception {
        byte[] keyBytes = base64Decoder.decodeBuffer(publicKey);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePublic(keySpec);
    }

    // 将base64编码后的私钥字符串转成PrivateKey实例
    private static PrivateKey getPrivateKey(String privateKey) throws Exception {
        byte[] keyBytes = base64Decoder.decodeBuffer(privateKey);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePrivate(keySpec);
    }


    // 私钥加密
    public static String encryptByPrivateKey(String content) throws Exception {
        // 获取私钥
        PrivateKey privateKey = getPrivateKey(privateKeyStr);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, privateKey);
        byte[] cipherText = cipher.doFinal(content.getBytes());
        String cipherStr = base64Encoder.encode(cipherText);
        return cipherStr;
    }


    // 公钥解密
    public static String decryptByPublicKey(String content) throws Exception {
        // 获取公钥
        PublicKey publicKey = getPublicKey(publicKeyStr);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, publicKey);
        byte[] cipherText = base64Decoder.decodeBuffer(content);
        byte[] decryptText = cipher.doFinal(cipherText);
        return new String(decryptText);
    }

    // 公钥解密
    public static String decryptByPublicKey(String publicKeyString, String content) throws Exception {
        // 获取公钥
        PublicKey publicKey = getPublicKey(publicKeyString);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, publicKey);
        byte[] cipherText = base64Decoder.decodeBuffer(content);
        byte[] decryptText = cipher.doFinal(cipherText);
        return new String(decryptText);
    }



    public static void main(String[] args) throws Exception {

        KeyPair keyPair = getKeyPair();
        privateKeyStr = new String(Base64.encodeBase64(keyPair.getPrivate().getEncoded()));
        publicKeyStr = new String(Base64.encodeBase64(keyPair.getPublic().getEncoded()));

        System.out.println("私钥：" + privateKeyStr);
        System.out.println("公钥：" + publicKeyStr);
        // 私钥加密
        String encryptedBytes2 = encryptByPrivateKey(data);
        System.out.println("私钥加密后：" + encryptedBytes2);
        // 公钥解密
        String decryptedBytes2 = decryptByPublicKey(encryptedBytes2);
        System.out.println("公钥解密后：" + decryptedBytes2);

    }


}