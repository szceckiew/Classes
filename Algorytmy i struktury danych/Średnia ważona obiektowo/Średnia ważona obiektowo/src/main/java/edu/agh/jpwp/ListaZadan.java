package edu.agh.jpwp;

import java.util.Random;

public class ListaZadan {

    public static void main(String[] args) {
        System.out.println("Wyliczanie średniej ważonej z listy");
        WeightedValue values[] = {
                new WeightedValue(10.5, 2),
                new WeightedValue(5.0, 1),
                new WeightedValue(1.2, 34),
                new WeightedValue(14.3, 3),
                new WeightedValue(1, 2)
        };

        double dresult = 0;
        int result = 0;
        for(int i = 0; i < values.length; ++i){
            WeightedValue wv = values[i];
            dresult += wv.getValue();
            result += wv.getWeight();
        }
        dresult = dresult / result;
        System.out.println("Wynik: " + dresult);
    }

    static class WeightedValue {
        private double value;
        private int weight;
        public WeightedValue(double v, int w){
            this.value = v;
            this.weight = w;
        }

        public double getValue(){
            return this.value;
        }

        public int getWeight(){
            return this.weight;
        }
    }
}
