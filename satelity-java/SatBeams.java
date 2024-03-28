import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Connection.Response;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class SatBeams extends WebPage {
	
	protected SatBeams(String url) {
		super(url);
		if(URL==null || URL=="" || URL!="https://www.satbeams.com/satellites?status=active") {
			URL = "https://www.satbeams.com/satellites?status=active";
			System.out.println("Adding default site as URL.");
		}
	}
	
	public void parseWebPage() {
		Document doc = null;
		Response r = null;
		
		try {
			r = Jsoup.connect(URL).userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.54").header("Accept-Encoding", "gzip, deflate").header("Content-Type", "text/html; charset=ISO-8859-1").referrer("http://www.google.com")
					.ignoreContentType(true).maxBodySize(0).timeout(0).ignoreHttpErrors(false).execute();
			doc = r.parse();
		} catch (Exception e) {
			System.out.println("Problems with URL. " + URL);
			return;
		}
		
		Elements table = doc.select("tbody").select("td:nth-of-type(4)").select("a");
		for(Element link : table) {
			try {
				satellites.add(createSatellite(link.absUrl("href").toString()));
			} catch (Exception e) {
				System.out.println("Couldn't parse satellite: " + link.absUrl("href").toString());
				continue;
			}
		}
		
	}
	
	public static Satellite createSatellite(String satelliteURL) throws IOException {
        Document satelliteDoc = Jsoup.connect(satelliteURL).userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.54").header("Accept-Encoding", "gzip, deflate").header("Content-Type", "text/html; charset=ISO-8859-1").referrer("http://www.google.com")
				.ignoreContentType(true).maxBodySize(0).timeout(0).ignoreHttpErrors(false).get();
        String[] dataRow = satelliteDoc.select("table.sat_grid1 tr").get(1).html().split("</b>");
        
        List<String> satelliteData = new ArrayList<>();
        int idx = 1;
        Document tempDoc;
        
        for (String dataString : dataRow) {
            for (String dataStringElement : dataString.split("<br>")) {
                tempDoc = Jsoup.parse(dataStringElement);
                if (idx % 2 == 0) {
                    satelliteData.add(tempDoc.text());
                }
                idx++;
            }
        }
        
        // 3 zmienne wchodzące do konstruktora
        String satName = satelliteData.get(0).split("\\(")[0].trim();
        float satDegree = Float.valueOf(satelliteData.get(2).split(" ")[2].substring(1, satelliteData.get(2).split(" ")[2].length() - 1));
        char satDir = satelliteData.get(2).split(" ")[3].charAt(0);
        
        Satellite resultSatellite = new Satellite(satName, satDegree, satDir);
        
        // Dodatkowe nazwy (jeżeli są)
        if (satelliteData.get(0).split("\\(").length > 1) {
            String[] nameStrings = satelliteData.get(0).split("\\(")[1].split(",");
            for (int i = 0; i < nameStrings.length; i++) {
                resultSatellite.setMultNames(satelliteData.get(0).split("\\(")[1].split(",")[i].split("\\)")[0]);
            }
        }
        
        // Reszta danych
        resultSatellite.setCluster(Integer.parseInt(satelliteData.get(2).split(" ")[0].replace("°", "")), satelliteData.get(2).split(" ")[1].charAt(0));
        resultSatellite.setNorad(Integer.parseInt(satelliteURL.split("=")[1]));
        resultSatellite.setOperator(satelliteData.get(5));
        resultSatellite.setLaunchSite(satelliteData.get(7));
        resultSatellite.setLaunchVehicle(satelliteData.get(8));
        if (satelliteData.get(9)!="") resultSatellite.setMass(Integer.parseInt(satelliteData.get(9)));
        resultSatellite.setManufacturer(satelliteData.get(11));
        resultSatellite.setModel(satelliteData.get(12));
        resultSatellite.setLaunchDate(satelliteData.get(6).strip());
        
        
        return resultSatellite;
    }
	
	public static void main (String[] args) throws Exception {
		WebPage w1 = new SatBeams("https://www.satbeams.com/satellites?status=active");
		WebPage w2 = new Kingofsat();
		
		w2.parseWebPage();
		w1.parseWebPage();
		System.out.println(w1.satellites.get(0));
		
//		Satellite temp = SatBeams.createSatellite("https://www.satbeams.com/satellites?norad=40982");
//		System.out.println(temp.toString());
//		

	}
}
