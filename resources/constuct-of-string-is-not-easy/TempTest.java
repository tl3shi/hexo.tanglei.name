package com.aliyun.ecs.ops.predict;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Objects;

import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * @author tanglei
 * @date 2020/11/6
 */
public class TempTest {

    /**
     * 将给定的字符串 trim 到指定大小
     * @param input
     * @param trimTo 需要 trim 的字节长度
     * @return trim 后的 String
     */
    public static String trimAsByte(String input, int trimTo) {
        if (Objects.isNull(input)) {
            return null;
        }
        byte[] bytes = input.getBytes();
        if (bytes.length > trimTo) {
            byte [] subArray = Arrays.copyOfRange(bytes, 0, trimTo);
            String res = new String(subArray);
            return res;
        }
        return input;
    }

    static String toByteStr(byte[] bytes) {
        StringBuffer sb = new StringBuffer("[");
        for(byte b : bytes) {
            sb.append(b).append(",");
        }
        sb.append("]");
        return sb.toString();
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
        {
            //"WeChat:tangleithu" bytes: [87,101,67,104,97,116,58,116,97,110,103,108,101,105,116,104,117,]
            // trim 8 bytes to: [87,101,67,104,97,116,58,116,]
            String xx = "WeChat:tangleithu";
            int trimSize = 8;
            System.out.println(String.format("\"%s\".length() = ", xx) + xx.length()); // 17
            System.out.println(String.format("\"%s\".getBytes().length = ", xx) + xx.getBytes().length); // 17
            System.out.println(String.format("trimAsByte(\"%s\", %s).length() = ", xx, trimSize) + trimAsByte(xx, trimSize).length());
            System.out.println(String.format("trimAsByte(\"%s\", %s).getBytes().length = ", xx, trimSize) + trimAsByte(xx, trimSize).getBytes().length);
        }
        System.err.println("--------");
        {
            //"程序猿石头" bytes: [-25,-88,-117,-27,-70,-113,-25,-116,-65,-25,-97,-77,-27,-92,-76,]
            // trim 8 bytes to: [-25,-88,-117,-27,-70,-113,-25,-116,]
            String xx = "程序猿石头";
            int trimSize = 8;
            System.out.println(String.format("\"%s\".length() = ", xx) + xx.length()); // 17
            System.out.println(String.format("\"%s\".getBytes().length = ", xx) + xx.getBytes().length); // 17
            System.out.println(String.format("trimAsByte(\"%s\", %s).length() = ", xx, trimSize) + trimAsByte(xx, trimSize).length());
            System.out.println(String.format("trimAsByte(\"%s\", %s).getBytes().length = ", xx, trimSize) + trimAsByte(xx, trimSize).getBytes().length);
        }
        {
            //byte[] bytes = new byte[]{-25,-88,-117,-27,-70,-113,-25,-119};
            byte[] bytes = new byte[] {-25,-88,-117,-27,-70,-113,-25,-116,-65,-25,-97,-77,-27,-92,-76};
            System.out.println("bytes.length = " + bytes.length);
            System.out.println("new String(bytes).getBytes().length = " + new String(bytes).getBytes().length); // 9
            System.out.println("new String(bytes, 'UTF-8').getBytes().length = " + new String(bytes, UTF_8).getBytes().length);// 9
            System.out.println("new String(bytes, 'UTF-8').getBytes().length = " + new String(bytes, ISO_8859_1).getBytes().length); // 16
        }

    }

}
