import java.net.URL;
import java.security.cert.Certificate;
//import java.io.*;
import javax.net.ssl.HttpsURLConnection;

public class VerifyHTTPSCert
{
    public static void main(String [] args)
    {
          URL url;
          String https_url = "https://www.google.com/";

          if (args.length > 0)
          {
              https_url = args[0];
              System.out.println("fetching " + https_url);
          }

          try
          {
              url = new URL(https_url);
              HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
              con.getResponseCode();
              Certificate[] certs = con.getServerCertificates();
              // XXX close
          }
          catch (Exception e)
          {
              e.printStackTrace();
          }
    }
}
