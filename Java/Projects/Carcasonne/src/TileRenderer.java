import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics2D;
import java.awt.geom.GeneralPath;
import java.awt.geom.Line2D;
import java.awt.image.BufferedImage;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;


public class TileRenderer extends DefaultTableCellRenderer{
    /* (non-Javadoc)
     * @see javax.swing.table.DefaultTableCellRenderer#getTableCellRendererComponent(javax.swing.JTable, java.lang.Object, boolean, boolean, int, int)
     */
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value,
            boolean isSelected, boolean hasFocus, int row, int column) {
        if(value == null){
            return null;
        }

        int height = table.getRowHeight();
        int width = table.getColumnModel().getColumn(column).getWidth();

        Tile tile = (Tile) value;
        
        ImageIcon icn = getRenderedImageIcon(width, height, tile);
        return new JLabel(icn);
    }
    
    /**
     * @param width - ImageIcon width
     * @param height - ImageIcon height
     * @param tile - Tile to model
     * @return ImageIcon for given tile that is width wide and height tall
     */
    public ImageIcon getRenderedImageIcon(int width, int height, Tile tile){
        if(tile == null){
            return null;
        }

        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_INDEXED);
        Graphics2D g2 = (Graphics2D)img.getGraphics();
        g2.setColor(Color.green);
        g2.fillRect(0, 0, width, height);
        
        for(int i = 0; i < Tile.NUM_SIDES; i++){
            if(tile.getSide(i) == Tile.CITY){
                drawCity(tile, g2, i, width, height);
            } else if (tile.getSide(i) == Tile.ROAD) {
                drawRoad(tile, g2, i, width, height);
            }
        }
        
        return new ImageIcon(img);
    }
    
    /**
     * @param tile - tile to mode
     * @param g2 - graphics object
     * @param side - side to place city
     * @param width
     * @param height
     * draw a city on g2 on the corresponding side
     */
    private void drawCity(Tile tile, Graphics2D g2, int side, int width, int height){
        GeneralPath city = new GeneralPath(GeneralPath.WIND_EVEN_ODD, 3);

        double x1, x2, y1, y2;

        // if side is top or bottom
        if(side % 2 == 0){
            x1 = 0;
            x2 = width;
        } else if (side == 3) { // if left side
            x1 = 0;
            x2 = 0;
        } else { // right side
            x1 = width;
            x2 = width;
        }

        // if side is left or right
        if (side % 2 == 1) {
            y1 = 0;
            y2 = height;
        } else if (side == 0) { // top side
            y1 = 0;
            y2 = 0;
        } else { // bottom side
            y1 = height;
            y2 = height;
        }

        city.moveTo(halve(width), halve(height));
        city.lineTo(x1, y1);
        city.lineTo(x2, y2);
        city.closePath();

        g2.setPaint(getOwnerColor(tile, side));
        g2.fill(city);
    }
    
    /**
     * @param tile - tile being modeled
     * @param g2 - graphics object
     * @param side - side to draw road
     * @param width
     * @param height
     * draw road on g2 on side corresponding to side
     */
    private void drawRoad(Tile tile, Graphics2D g2, int side, int width, int height){
        double x2;
        double y2;
        // if side is top or bottom
        if(side % 2 == 0){
            x2 = halve(width);
        } else if (side == 1) { // if side is right
            x2 = width;
        } else { // if side is left
            x2 = 0;
        }

        // if side is left or right
        if(side % 2 == 1){
            y2 = halve(height);
        } else if (side == 0) { // if top side
            y2 = 0;
        } else { // if bottom side
            y2 = height;
        }

        g2.setColor(getOwnerColor(tile, side));
        g2.setStroke(new BasicStroke(height/12));
        g2.draw(new Line2D.Double(halve(width), halve(height), x2, y2));
    }
    
    /**
     * @param tile
     * @param side - side to get owner
     * @return Color to be drawn
     * owners color or Color.Gray if null
     */
    private Color getOwnerColor(Tile tile, int side){
        Player owner = tile.getOwner(side);
        if(owner != null){
            return owner.getColor();
        }

        return Color.GRAY;
    }
    
    /**
     * @param length
     * @return half of length as a double
     */
    private double halve(int length){
        return ((double) length)/2;
    }

}
