public class TestURL {
    static void conflicts() throws Exception {
        String urlSrc = "http://test_1.tanglei.name/testurl";
        java.net.URL url = new java.net.URL(urlSrc);
        System.out.println(url.getHost()); //test_1.tanglei.name
        System.out.println(url.getProtocol()); //http
        System.out.println(url.getPath()); // /testurl
        java.net.URI uri = new java.net.URI(urlSrc);
        //Typo System.err.println("uri.getHost() == uri.toURL().getHost() is: " + (uri.getHost() == uri.toURL().getHost()));
        //Attention: NullPointerException
        System.err.println("uri.toURL().getHost().equals(uri.getHost())) is: " + (uri.toURL().getHost().equals(uri.getHost())));
        System.out.println(uri.getHost()); //null    
    }

    static String getContent(java.net.URL url) throws Exception {
        java.net.URLConnection conn = url.openConnection();
        java.io.InputStreamReader in = new java.io.InputStreamReader(conn.getInputStream(), "utf-8");
        java.io.BufferedReader reader = new java.io.BufferedReader(in);    
        StringBuilder sb = new StringBuilder();
        int c = -1;
        while ((c = reader.read()) != -1) {
            sb.append((char)c);
        }
        reader.close();
        in.close();
        String response = sb.toString();
        return response;
    }

    public static void main(String[] args) throws Exception {
        conflicts();
        String srcUrl = "http://test_1.tanglei.name/testurl";
        java.net.URL url = new java.net.URL(srcUrl);
        System.out.println("\nurl result:\n" + getContent(url)); // OK
        System.out.println("\nurl.toURI.toURL result: \n" + getContent(url.toURI().toURL())); // OK
        java.net.URI uri = new java.net.URI(srcUrl);
        System.out.println("\nuri.toURL result: \n" + getContent(uri.toURL())); // OK
        java.net.URI uri2 = null;
        try {
            uri2 = new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null); //throw Exception: java.lang.IllegalArgumentException: protocol = http host = null
            System.out.println("\nuri2.toURL result:\n" + getContent(uri2.toURL())); 
        } catch (Exception ex) {
            System.err.println("new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null) error: " + ex.getMessage());
            ex.printStackTrace();
        }

        try {
            uri2 = new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null); //throw Exception: java.lang.IllegalArgumentException: protocol = http host = null
            System.out.println("\nuri2.toURL result:\n" + getContent(uri2.toURL())); 
        } catch (Exception ex) {
            System.err.println("new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null) error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
