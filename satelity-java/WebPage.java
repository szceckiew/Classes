import java.util.ArrayList;
import java.util.List;

public abstract class WebPage {
	public List<Satellite> satellites = new ArrayList<>();
	protected String URL = null;
	
	protected WebPage(String url) {
		URL = url;
	}
	public abstract void parseWebPage();
}
