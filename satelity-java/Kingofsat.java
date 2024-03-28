import java.io.IOException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Kingofsat extends WebPage {

    private final static String url = "https://pl.kingofsat.net/satellites.php";

    
    public Kingofsat()
    {
    	super(url);
    }
    
    @Override
    public void parseWebPage() {
    	// Parse the web page
    	Document doc = new Document(url);
    	try {
    	
			 doc = Jsoup.connect(url).get();
		}
		catch(IOException ignored)
		{
			
		}
        Elements media = doc.select(".footable");
        
        System.out.println("1. TABLES: "+media.size());
        
        //System.out.println("--------------------------------------\n"+media.first().children()+"\n--------------------------------------\n");
        //System.out.println("--------------------------------------\n"+media.first().getAllElements()+"\n--------------------------------------\n");
        
        System.out.print("2. Select TR attribute.");
        Elements tmp = media.first().select("TBODY");
        String[][] dane = new String[120][5];
        int i = 0;
        Integer[] kolumny = new Integer[5];
        kolumny[0] = 0;
        kolumny[1] = 1;
        kolumny[2] = 2;
        kolumny[3] = 7;
        kolumny[4] = 12;
        for (Element el: tmp) {
                Elements tmp2 = el.select("TR");
                for(Element el2: tmp2){
                    for(int j = 0;j<5;j++){    
                        String text = el2.children().get(kolumny[j]).text();
                        dane[i][j] = text;
                    }
                    i++;
                    System.out.println(i);
                }
        }
        for(int x = 0;x<120;x++){
        	
        	String position = dane[x][3];
        	String dir = position.substring(position.length() - 1);
        	char dir2 = dir.charAt(0);
        	String degree = position.substring(0, position.length() - 2);
        	float degree2 = Float.parseFloat(degree);
        	Satellite satelita = new Satellite(dane[x][1], degree2, dir2);
        	satelita.setCluster( Float.parseFloat(dane[x][0].substring(0, dane[x][0].length() - 2)), (dane[x][0].substring(dane[x][0].length() - 1)).charAt(0));
        	satelita.setNorad(Integer.parseInt(dane[x][2]));
           	satelita.setUpdateKing(dane[x][4]);
        	
        	
        	satellites.add(satelita); 
        	
            
        }	
    	
    	
    	
    	
    }
    
	public static void main(String[] args) throws IOException {
        
        Kingofsat test = new Kingofsat();
        test.parseWebPage();
        System.out.println(test.satellites);
        
        
	}      
}
