public class Position {
    public float degree;
    public char dir;
    
    @Override
    public String toString() {
    	return Float.toString(degree) + " " + Character.toString(dir);
    }
    
}
