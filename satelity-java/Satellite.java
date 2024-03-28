import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Satellite {

    private List<String> names = new ArrayList<>();
    private final Position position = new Position();
    private final Position clusterPosition = new Position();

    // indywidualne parametry - dla danej strony wlasne
    
    private int NORAD = 0;
    private String operator = "";
    private String band = "";
    private String launchDate = "";
    private String launchSite = "";
    private String launchVehicle = "";
    private int mass = 0;
    private String manufacturer = "";
    private String model = "";
    
    private Date upDate = null;
    
    
    public String toString() {
    	String a1 = "\nPosition: " + position.degree + " " + position.dir + "\n" + "NORAD: " + NORAD;
    	a1+="\nCluster position: " + clusterPosition.degree + " " + clusterPosition.dir;
    	if (operator!="") a1+="\nOperator: " + operator;
    	if (launchDate!="") a1+="\nLaunch date: " + launchDate;
    	if (launchSite!="") a1+="\nLaunch site: " + launchSite;
    	if (launchVehicle!="") a1+="\nLaunch vehicle: " + launchVehicle;
    	if (mass!=0) a1+="\nLaunch mass (kg): " + mass;
    	if (manufacturer!="") a1+="\nManufacturer: " + manufacturer;
    	if (model!="") a1+="\nModel: " + model;
    	if (upDate!=null) a1+="\nUpdate: " + upDate;
    	return names.toString() + a1;
    }
    
    // dokladne pozycje w konstruktorze
    public Satellite(String name, float degree, char dir)
    {
        if(name.length() == 0)
        {
            return;
        }

        names.add(name);

        position.degree = degree;
        position.dir = dir;
        
    }
    
    public List<String> getNames(){
    	return names;
    }
    
    // jezeli wiecej nazw, to wielokrotnie wywolac metode

    public void setMultNames(String n1) {
    	names.add(n1);
    }
    
    public void setCluster(float degree, char dir) {
    	clusterPosition.degree = degree;
    	clusterPosition.dir = dir;
    }
    
    public String getClusterPos() {
    	return clusterPosition.toString();
    }
    
    public int getNorad() {
    	return this.NORAD;
    }
    
    public void setNorad(int num) {
    	this.NORAD = num;
    }
    
    public String getOperator() {
    	return this.operator;
    }
    
    public void setOperator(String op) {
    	this.operator = op;
    }
    
    public String getBand() {
    	return this.band;
    }
    
    public void setBand(String ban) {
    	this.band = ban;
    }
    
    //trzeba odpowiedni format Daty dac
    public String getLaunchDate() {
    	return this.launchDate;
    }
    
    public void setLaunchDate(String date) {
    	this.launchDate = date;
    }
    
    public String getLaunchSite() {
    	return this.launchSite;
    }
    
    public void setLaunchSite(String site) {
    	this.launchSite = site;
    }
    
    public String getLaunchVehicle() {
    	return this.launchVehicle;
    }
    
    public void setLaunchVehicle(String veh) {
    	this.launchVehicle = veh;
    }
    
    public int getMass() {
    	return this.mass;
    }
    
    public void setMass(int mass) {
    	this.mass = mass;
    }
    
    public String getManufacturer() {
    	return this.manufacturer;
    }
    
    public void setManufacturer(String man) {
    	this.manufacturer = man;
    }
    
    public String getModel() {
    	return this.model;
    }
    
    public void setModel(String mod) {
    	this.model = mod;
    }
    
    public Date getUpateFlySat() {
    	return this.upDate;
    }
    
    public void setUpdateFlySat(String date) {
    	SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy");
    	try {
    		this.upDate = format.parse(date);
		} catch (ParseException e) {
			this.upDate = null;
		}
    }
    
    public Date getUpateKing() {
    	return this.upDate;
    }
    
    public void setUpdateKing(String date) {
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    	try {
    		this.upDate = format.parse(date);
		} catch (ParseException e) {
			this.upDate = null;
		}
    }
    
    


}
