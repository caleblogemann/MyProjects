import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.MatteBorder;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

/**
 * @author caleblogemann
 *
 */
public class View extends JFrame implements TableModelListener, ActionListener, ListSelectionListener{
    private Game boardModel;
    
    // Gui objects that support actions
    JMenuItem newGame;
    JMenuItem exit;
    JButton resizeButton;
    JButton newGameButton;
    JButton rotateCWButton;
    JButton rotateCCWButton;
    JButton zoomInButton;
    JButton zoomOutButton;
    JComboBox<Integer> sizeSelector;
    JComboBox<Integer> zoomSpeedSelector;

    // Components to be updated
    JLabel player1Score;
    JLabel player2Score;
    JLabel turnLabel;
    JLabel nextTile;
    
    private final int NEXT_TILE_SIZE=65;

    // JTable
    JTable board;
    JScrollPane scrollPane;
    
    TileRenderer tileRenderer;

    // cotrols how fast each cell grows in pixels
    int zoomSpeed;

    /**
     * @param boardModel
     * construct a view communicating with board model
     */
    public View(Game boardModel){
        // save boardModel
        this.boardModel = boardModel;

        boardModel.addTableModelListener(this);

        setLayout(new BorderLayout());
        
        // instantiate tile renderer
        tileRenderer = new TileRenderer();

        createMenu();
        createBoardPanel();
        createSidePanel();

        setTitle("Carcasonne");
        setExtendedState(JFrame.MAXIMIZED_BOTH);
        setVisible(true);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);

        // Pause for window to become fully extended before resizing
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // resize Board to fill pane
        fitBoardToScrollPane();
    }

    /**
     * @param zoomSpeed
     * update zoom speed
     */
    private void setZoomSpeed(int zoomSpeed){
        this.zoomSpeed = zoomSpeed;
    }

    /**
     * @return current zoom speed
     */
    private int getZoomSpeed(){
        return this.zoomSpeed;
    }

    /**
     * Create menu bar
     */
    private void createMenu(){
        // Create a menu
        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu   = new JMenu("File");
        fileMenu.setMnemonic(KeyEvent.VK_F);
        
        newGame = new JMenuItem("New Game");
        newGame.addActionListener(this);
        newGame.setMnemonic(KeyEvent.VK_N);
        newGame.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, Toolkit.getDefaultToolkit().getMenuShortcutKeyMask()));
        
        exit = new JMenuItem("Exit");
        exit.addActionListener(this);
        exit.setMnemonic(KeyEvent.VK_E);
        exit.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_W, Toolkit.getDefaultToolkit().getMenuShortcutKeyMask()));

        fileMenu.add(newGame);
        fileMenu.add(exit);

        menuBar.add(fileMenu);
        setJMenuBar(menuBar);
    }

    /**
     * create the panel to display information
     */
    private void createSidePanel(){
        JPanel sidePanel = new JPanel();
        sidePanel.setLayout(new GridLayout(10, 1));

        // display next tile to be placed
        nextTile = new JLabel();
        updateNextTile();
        JPanel nextTilePanel = new JPanel();
        nextTilePanel.add(nextTile);
        sidePanel.add(nextTilePanel);
        
        // buttons for rotating tile
        JPanel rotateButtonsPanel = new JPanel();
        rotateCWButton = new JButton();
        try{
            Image rotateCWImage = ImageIO.read(getClass().getResource("resources/rotateCW.png"));
            rotateCWButton.setIcon(new ImageIcon(rotateCWImage));
        } catch (IOException e) {
            e.printStackTrace();
        }
        rotateCWButton.addActionListener(this);
        rotateButtonsPanel.add(rotateCWButton);

        rotateCCWButton = new JButton();
        try{
            Image rotateCCWImage = ImageIO.read(getClass().getResource("resources/rotateCCW.png"));
            rotateCCWButton.setIcon(new ImageIcon(rotateCCWImage));
        } catch (IOException e) {
            e.printStackTrace();
        }
        rotateCCWButton.addActionListener(this);
        rotateButtonsPanel.add(rotateCCWButton);
        sidePanel.add(rotateButtonsPanel);

        // whose turn it is 
        turnLabel = new JLabel();
        turnLabel.setFont(new Font("Serif", Font.BOLD, 30));
        sidePanel.add(turnLabel);
        updateTurnLabel();

        JPanel player1Panel = new JPanel();
        player1Panel.setLayout(new GridLayout(1,2));
        // label
        JLabel player1Label = new JLabel("Player 1");
        player1Label.setForeground(boardModel.getPlayer1().getColor());
        player1Label.setFont(new Font("Serif", Font.BOLD, 30));

        // score
        player1Score = new JLabel("0");
        player1Score.setFont(new Font("Serif", Font.BOLD, 30));
        player1Score.setHorizontalAlignment(SwingConstants.RIGHT);

        player1Panel.add(player1Label);
        player1Panel.add(player1Score);
        sidePanel.add(player1Panel);

        JPanel player2Panel = new JPanel();
        player2Panel.setLayout(new GridLayout(1,2));
        // label
        JLabel player2Label = new JLabel("Player 2");
        player2Label.setForeground(boardModel.getPlayer2().getColor());
        player2Label.setFont(new Font("Serif", Font.BOLD, 30));
        
        // score
        player2Score = new JLabel("0");
        player2Score.setFont(new Font("Serif", Font.BOLD, 30));
        player2Score.setHorizontalAlignment(SwingConstants.RIGHT);
        
        player2Panel.add(player2Label);
        player2Panel.add(player2Score);
        
        sidePanel.add(player2Panel);

        // drop down to select size
        JPanel sizeSelectorPanel = new JPanel();
        JLabel sizeSelectorLabel = new JLabel("Select Size");
        sizeSelectorPanel.add(sizeSelectorLabel);

        int minSize = 3;
        int maxSize = 21;
        int numIterations = (maxSize - minSize)/2;
        Integer[] sizeArray = new Integer[numIterations + 1];
        for(int i = 0; i <= numIterations; i++){
            sizeArray[i] = minSize + 2 * i;
        }

        sizeSelector = new JComboBox<Integer>(sizeArray);
        sizeSelector.addActionListener(this);
        sizeSelector.setSelectedItem(boardModel.getSize());
        sizeSelectorPanel.add(sizeSelector);

        sidePanel.add(sizeSelectorPanel);

        // new game button
        newGameButton = new JButton("New Game");
        newGameButton.addActionListener(this);
        sidePanel.add(newGameButton);
        
        // resize button
        resizeButton = new JButton("Resize");
        resizeButton.addActionListener(this);
        sidePanel.add(resizeButton);

        // zoom in and zoom out buttons
        JPanel zoomButtonsPanel = new JPanel();
        zoomInButton = new JButton("Zoom In(+)");
        zoomInButton.addActionListener(this);

        zoomOutButton = new JButton("Zoom Out(-)");
        zoomOutButton.addActionListener(this);

        zoomButtonsPanel.add(zoomInButton);
        zoomButtonsPanel.add(zoomOutButton);
        sidePanel.add(zoomButtonsPanel);

        // zoom speed
        JPanel zoomSpeedPanel = new JPanel();
        JLabel zoomSpeedLabel = new JLabel("Zoom Speed");
        zoomSpeedPanel.add(zoomSpeedLabel);

        int minSpeed = 20;
        int maxSpeed = 30;
        Integer[] zoomSpeedArray = new Integer[maxSpeed - minSpeed + 1];
        for(int i = minSpeed; i <= maxSpeed; i++){
            zoomSpeedArray[i - minSpeed] = i;
        }

        zoomSpeedSelector = new JComboBox<Integer>(zoomSpeedArray);
        zoomSpeedSelector.addActionListener(this);
        zoomSpeedSelector.setSelectedItem(maxSpeed);
        zoomSpeedPanel.add(zoomSpeedSelector);
        setZoomSpeed(maxSpeed);

        sidePanel.add(zoomSpeedPanel);
        
        sidePanel.setBorder(new MatteBorder(0,3,0,0, Color.BLACK));
        add(sidePanel, BorderLayout.EAST);
    }

    /**
     * create panel to display board as a Jtable
     */
    private void createBoardPanel(){
        board = new JTable(boardModel);
        //board.setBackground(Color.BLACK);
        board.setGridColor(Color.BLACK);
        //board.setBorder(new MatteBorder(3,3,3,3,Color.BLACK));
        board.setDefaultRenderer(Tile.class, tileRenderer);
        board.setTableHeader(null);
        board.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        board.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        board.setCellSelectionEnabled(true);
        board.getSelectionModel().addListSelectionListener(this);

        scrollPane = new JScrollPane(board);
        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        add(scrollPane, BorderLayout.CENTER);
    }

    /**
     * @param size
     * resize board with cells whose height and width are size
     */
    private void resizeBoard(int size){
        board.setRowHeight(size);

        int numColumns = boardModel.getSize();
        for(int i = 0; i < numColumns; i++){
            board.getColumnModel().getColumn(i).setPreferredWidth(size);
        }
    }

    /**
     * make board cells square
     */
    private void squareBoardCells(){
        resizeBoard(board.getRowHeight());
    }

    /**
     * fit cells into scroll pane
     * so no scrolling is necessary
     */
    private void fitBoardToScrollPane(){
        int size = boardModel.getSize();
        int height = (int) scrollPane.getSize().getHeight()/size;
        int width  = (int) scrollPane.getSize().getWidth()/size;

        // make sure valid height
        if(height < 1){
            height = 1;
        }

        // make sure valid width
        if(width < 1){
            width = 1;
        }

        resizeBoard(Math.min(height, width));
    }

    /**
     * zoom in on board with current zoom speed
     */
    private void zoomInOnBoard(){
        double zoomPercentage = 1 + getZoomSpeed()/100.0;
        int rowHeight = (int)(board.getRowHeight() * zoomPercentage);
        resizeBoard(rowHeight);
    }

    /**
     * zoom out on board with current zoom speed
     */
    private void zoomOutOnBoard(){
        double zoomPercentage = 1 - getZoomSpeed()/100.0;
        int rowHeight = (int) (board.getRowHeight() * zoomPercentage);
        if(rowHeight < 1){
            rowHeight = 1;
        }
        resizeBoard(rowHeight);
    }
    
    /**
     * update score labels
     */
    private void updateScore(){
        int player1 = boardModel.getPlayer1().getScore();
        int player2 = boardModel.getPlayer2().getScore();
        player1Score.setText("" + player1);
        player2Score.setText("" + player2);
    }

    /**
     * update current players turn label
     */
    private void updateTurnLabel(){
        Player currentPlayer = boardModel.getCurrentPlayer();
        turnLabel.setText(currentPlayer.getName() + "'s Turn");
        turnLabel.setForeground(currentPlayer.getColor());
    }
    
    /**
     * update next tile display
     */
    private void updateNextTile(){
        nextTile.setIcon(tileRenderer.getRenderedImageIcon(NEXT_TILE_SIZE,
                         NEXT_TILE_SIZE, boardModel.getCurrentTile()));
    }
    
    /**
     * call all update methods
     */
    private void updateAll(){
        updateNextTile();
        updateTurnLabel();
        updateScore();
        squareBoardCells();
    }

    /* (non-Javadoc)
     * @see javax.swing.event.TableModelListener#tableChanged(javax.swing.event.TableModelEvent)
     */
    @Override
    public void tableChanged(TableModelEvent e) {
        return;
    }

    /* (non-Javadoc)
     * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource().equals(exit)) {
            System.exit(0);
        } else if (e.getSource().equals(newGame) || e.getSource().equals(newGameButton)) {
            boardModel.reset();
            updateAll();
        } else if (e.getSource().equals(resizeButton)) {
            fitBoardToScrollPane();
        } else if (e.getSource().equals(rotateCWButton)) {
            boardModel.rotateCurrentTileCW();
            updateNextTile();
        } else if (e.getSource().equals(rotateCCWButton)) {
            boardModel.rotateCurrentTileCCW();
            updateNextTile();
        } else if (e.getSource().equals(sizeSelector)) {
            int size = sizeSelector.getItemAt(sizeSelector.getSelectedIndex());
            if(size != boardModel.getSize()){
                boardModel.reset(size);
                updateAll();
            }
        } else if (e.getSource().equals(zoomInButton)){
            zoomInOnBoard();
        } else if (e.getSource().equals(zoomOutButton)){
            zoomOutOnBoard();
        } else if (e.getSource().equals(zoomSpeedSelector)){
            setZoomSpeed(zoomSpeedSelector.getItemAt(zoomSpeedSelector.getSelectedIndex()));
        }
    }

    /* (non-Javadoc)
     * @see javax.swing.event.ListSelectionListener#valueChanged(javax.swing.event.ListSelectionEvent)
     */
    @Override
    public void valueChanged(ListSelectionEvent e) {
        int column = board.getSelectedColumn();
        int row = board.getSelectedRow();

        if(row > -1 && column > -1 && !boardModel.isGameFinished()){
            if(boardModel.isPlayable(row, column)){
                boardModel.insertTile(row, column);
                updateAll();
                if(boardModel.isGameFinished()){
                    // popup
                    JOptionPane.showMessageDialog(this, "Congratulations "
                            + boardModel.getWinner().getName()
                            + " is the Winner", "Game Over",
                            JOptionPane.PLAIN_MESSAGE);
                }
            } else {
                JOptionPane.showMessageDialog(this, "That is an illegal move",
                        "Illegal Move", JOptionPane.WARNING_MESSAGE);
            }
        }
    }
}
