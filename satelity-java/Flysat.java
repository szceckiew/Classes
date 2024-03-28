import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

public class Flysat extends WebPage{
    public Flysat() {
        super("https://www.flysat.com/en/satellitelist");

    }

    private Position prevCluster = new Position();

    @Override
    public void parseWebPage() {
        try {
            Document strona = Jsoup.connect(URL).get();

            Elements elements = strona.getElementsByAttributeValue("bgcolor", "#b9dcff");

            elements.remove(0);
            for (Element element : elements) {

                Position position = new Position();
                if (element.children().size() == 5) {

                    int end_of_degree = element.child(1).text().indexOf("°");
                    position.degree = Float.parseFloat(element.child(1).text().substring(0, end_of_degree));
                    if(element.child(1).text().substring(end_of_degree + 1).charAt(0) == ' ')
                        position.dir = element.child(1).text().substring(end_of_degree + 2).charAt(0);
                    else
                        position.dir = element.child(1).text().substring(end_of_degree + 1).charAt(0);

                    String[] names = element.child(0).text().split("\\(");
                    if(names[0].charAt(names[0].length()-1) == ' ')
                    {
                        names[0] = names[0].substring(0, names[0].length()-1);
                    }


                    Satellite satellite = new Satellite(names[0], position.degree, position.dir);
                    try {
                        satellite.setMultNames(names[1].substring(0, names[1].length() - 1));
                    } catch (ArrayIndexOutOfBoundsException ignored) {}
                    satellite.setCluster(prevCluster.degree, prevCluster.dir);

                    System.out.println(satellite);
                    satellite.setBand(element.child(3).text());

                    satellite.setLaunchDate(element.child(4).text());

                    satellites.add(satellite);

                    continue;
                }

//                prevCluster.dir = '0';

                int end_of_degree = element.child(2).text().indexOf("°");
                position.degree = Float.parseFloat(element.child(2).text().substring(0, end_of_degree));
                if(element.child(2).text().substring(end_of_degree + 1).charAt(0) == ' ')
                    position.dir = element.child(2).text().substring(end_of_degree + 2).charAt(0);
                else
                    position.dir = element.child(2).text().substring(end_of_degree + 1).charAt(0);

                String[] names = element.child(1).text().split("\\(");

                if(names[0].charAt(names[0].length()-1) == ' ')
                {
                    names[0] = names[0].substring(0, names[0].length()-1);
                }

                Satellite satellite = new Satellite(names[0], position.degree, position.dir);

                try {
                    satellite.setMultNames(names[1].substring(0, names[1].length() - 1));
                } catch (ArrayIndexOutOfBoundsException ignored) {}

                if (element.child(0).text().equals("")) {
                    satellite.setCluster(position.degree, position.dir);
                }
                else
                {
                    Position cluster = new Position();
                    end_of_degree = element.child(0).text().indexOf("°");
                    cluster.degree = Float.parseFloat(element.child(0).text().substring(0, end_of_degree));
                    if(element.child(0).text().substring(end_of_degree + 1).charAt(0) == ' ')
                        cluster.dir = element.child(0).text().substring(end_of_degree + 2).charAt(0);
                    else
                        cluster.dir = element.child(0).text().substring(end_of_degree + 1).charAt(0);

                    satellite.setCluster(cluster.degree, cluster.dir);

                    prevCluster = cluster;
                }

                satellite.setBand(element.child(4).text());

                satellite.setLaunchDate(element.child(5).text());

                satellites.add(satellite);
            }
        } catch (IOException ignored)
        {

        }
    }
}
