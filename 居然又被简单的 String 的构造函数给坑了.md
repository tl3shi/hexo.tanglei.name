

https://stackoverflow.com/questions/38265016/byte-array-length-varies-before-and-after-transformation



```java
private static String trim(String message, int trimSize) {
    if (Strings.isNullOrEmpty(message)) {
        return "";
    }
    byte[] bytes = message.getBytes();
    if (bytes.length > trimSize) {
        byte [] subArray = Arrays.copyOfRange(bytes, 0, trimSize);
        return new String(subArray);
    }
    return message;
}

public static void main(String[] args) {
    String xx = "程序猿石头";
    System.out.println(xx.getBytes().length); // 15
    System.out.println(trim(xx, 8));
    System.out.println(trim(xx, 8).getBytes().length); // 9
}
```

