/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.harp.gui;

import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.JTextArea;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.*;
import org.jlab.AutoLogEntry.MakeLogEntry;
import org.jlab.data.graph.DataSetXY;
import org.jlab.data.graph.DataTable;
import org.jlab.data.harp.HarpGenericAnalyzer;
import org.jlab.harp.utils.HarpFileUtility;
import org.jlab.scichart.canvas.ScChartCanvas;

/**
 *
 * @author gavalian
 */
public class HarpScanGUIFULL extends JFrame implements ActionListener {
    private ParameterPanel wirePositions = null;
    private ParameterPanel peakPositions = null;
    private JSplitPane  splitPane = null;
    private Integer     numberOfWires  = 3;
    public  Integer     harpWireToFit  = 4;
    private JComboBox comboWire = null; 
    private DataTable   dataTable = new DataTable();
    private ScChartCanvas canvas  = null;
    private JTextArea jta1 = null;
    private String   currentFileName         = "";
    private String   currentFilePath         = "";
    private String   currentHarpFilesDir     = ".";
    private String   all_harps_dir           = "";
    public  String   this_harp_dir           = "";
    private double   wireScanPositions[]     = null;
    //private String   autoLoadFileStartsWith  = "harp_generic";
    private String   autoLoadFileStartsWith  = "harp_";
    private Properties analyzerProperties    = new Properties();
    private String     harpScanAnalyzerType  = "tagger";
    private String     propertiesFileName    = "";
    private List fileHeader;  
    String[] counterNames = new String[]{"F Cup",
        "Upstream Left","UpstreamRight",
            "Tagger Left", "Tagger Right","Tagger Top",
            "Downstream Left","Downstream Right",
            "Downstream Top", "Downstream Bottom",
            "HPS Left","HPS Right",
            "HPS-T","HPS-SC"
        };
    private HarpGenericAnalyzer  harpAnalyzer = new HarpGenericAnalyzer();

    public HarpScanGUIFULL(String type, double[] limits){
        super(type);
                
        this.setSize(1200, 800);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        splitPane = new JSplitPane();
        splitPane.setDividerLocation(400);
        //JSplitPane split_pan2 = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, splitPane);
        
        
        JPanel leftPanel = new JPanel();
        leftPanel.setLayout(new BoxLayout(leftPanel, BoxLayout.Y_AXIS));

        JPanel buttonPanel = new JPanel();
        this.initButtons(buttonPanel);
        leftPanel.add(buttonPanel);
        
        splitPane.setLeftComponent(leftPanel);
               
        canvas = new ScChartCanvas(500,500,1,1);
        splitPane.setRightComponent(canvas);
        splitPane.addComponentListener(canvas);
        this.addComponentListener(canvas);                

        this.add(splitPane);        
        this.pack();
        this.setVisible(true);
        //this.initializeEnvironment(type);
        //this.initializeDirectory();
    }
    
    public void setHarpType(String harptype){
	this.this_harp_dir = harptype;
	harpAnalyzer.setName(harptype);
    }
    public void initializeEnvironment(String harStyle){
        all_harps_dir = System.getenv("HARPFILE_DIR");
        
	currentHarpFilesDir = all_harps_dir + "/" + this_harp_dir;
	System.out.println("current Harp dir = " + currentHarpFilesDir);
	System.out.println("this.this_harp_dir = " + this_harp_dir);
	
        if(currentHarpFilesDir==null){
            System.err.println("** ERROR ** : --> HARPFILE_DIR environment is not defined...");                      
        } else {
            File harpFile = HarpFileUtility.lastFileModified(currentHarpFilesDir,autoLoadFileStartsWith);
            currentFileName = harpFile.getName();
            currentFilePath = harpFile.getAbsolutePath();
        }
        
        System.err.println("[CURRENT PATH] file : -----> " + currentFilePath);
        String etcDirectory = System.getenv("SCRIPT_DIR");

        if(etcDirectory==null){
            System.err.println("** ERROR ** : --> SCRIPT_DIR environment is not defined...");
        } else {
            String propertyFile = etcDirectory + "/../etc/harpscan.properties";
            propertiesFileName  = propertyFile;
            
            //this.initProperties();
            File   configFile   = new File(propertyFile);
            System.err.append("Oppening File: ---> " + propertyFile + "  status = " + configFile.exists());
            if(configFile.exists()==true){
                System.err.println("Loading Properties : ----> " + propertyFile);
                try {
                    analyzerProperties.load(new FileInputStream(configFile));
                } catch (IOException ex) {
                    Logger.getLogger(HarpScanGUIFULL.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else { 
                System.err.println("  ***************** \n");
                this.initProperties();
            }
            
            //this.initProperties();           
        } 
        
        analyzerProperties.list(System.err);
    }
    
    public void initProperties(){
       
        analyzerProperties.clear();
        analyzerProperties.setProperty("scan.limits.tagger.x.min", "52.0");
        analyzerProperties.setProperty("scan.limits.tagger.x.max", "56.0");
        analyzerProperties.setProperty("scan.limits.tagger.y.min", "20.0");
        analyzerProperties.setProperty("scan.limits.tagger.y.max", "30.0");
        analyzerProperties.setProperty("scan.limits.tagger.sc45.min", "20.0");
        analyzerProperties.setProperty("scan.limits.tagger.sc45.max", "30.0");
        
        analyzerProperties.setProperty("scan.limits.2h03.x.min", "52.0");
        analyzerProperties.setProperty("scan.limits.2h03.x.max", "56.0");
        analyzerProperties.setProperty("scan.limits.2h03.y.min", "20.0");
        analyzerProperties.setProperty("scan.limits.2h03.y.max", "30.0");
        analyzerProperties.setProperty("scan.limits.2h03.sc45.min", "20.0");
        analyzerProperties.setProperty("scan.limits.2h03.sc45.max", "30.0");
        
        analyzerProperties.setProperty("scan.limits.2c21.x.min", "52.0");
        analyzerProperties.setProperty("scan.limits.2c21.x.max", "56.0");
        analyzerProperties.setProperty("scan.limits.2c21.y.min", "20.0");
        analyzerProperties.setProperty("scan.limits.2c21.y.max", "30.0");
        
        System.err.println("Saving Propertis : ----> " + propertiesFileName);
        
        
        File outfile = new File(propertiesFileName);
        try {
            
            analyzerProperties.store(new FileOutputStream(outfile), null);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(HarpScanGUIFULL.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(HarpScanGUIFULL.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public void initializeDirectory(){
  
        all_harps_dir = System.getenv("HARPFILE_DIR");
	currentHarpFilesDir = all_harps_dir + "/" + this_harp_dir;

	if(currentHarpFilesDir==null){
            currentHarpFilesDir = ".";
            System.err.println("--> ERROR: environment variable HARPFILE_DIR is not set");
        } else {
            File harpFile = HarpFileUtility.lastFileModified(currentHarpFilesDir,autoLoadFileStartsWith );
            currentFileName = harpFile.getName();
            currentFilePath = harpFile.getAbsolutePath();
            System.err.println("file : -----> " + currentFilePath);
            //this.loadData(currentFilePath);
        }
    }
    
    public String getTempImagePath(){
        String time_stamp = MakeLogEntry.getTimeStamp();
        StringBuilder str = new StringBuilder();
        if(System.getenv("SCRIPT_DIR")!=null){
            //str.append(System.getenv("SCRIPT_DIR"));
            //str.append("/../fit_Image/temptorary_image_scan.png");
            //str.append("/../etc/temp/temptorary_image_scan.png");
            str.append("/home/hpsrun/screenshots/" + this_harp_dir +"_"+ time_stamp + ".png");
                        
            return str.toString();
        }
        return null;
    }
    
    public void makeLogEntry(){               
        harpAnalyzer.setPVs(this_harp_dir);
        String imagePath = this.getTempImagePath();
        if(imagePath!=null){        
            canvas.exportPNG(imagePath);
            MakeLogEntry log = new MakeLogEntry();
            log.setTitle("Scan of " + this_harp_dir);
            StringBuilder str = new StringBuilder();
//           for(int loop = 0; harpAnalyzer.functions.size() >= loop;loop++){
              for(int loop = 0; harpAnalyzer.getHarpFuncs().size() > loop;loop++){ 
                  System.out.println("Loop = " + loop);
                String[] labels = harpAnalyzer.getLegend(loop, this_harp_dir);
                for(String text : labels) {
                    str.append(text);
                    str.append("\n");
                }
                
                if( loop == 2 )
                {
                   String[] alphaAB =  harpAnalyzer.getLegendAlphaAB(this_harp_dir);
                    for(String text : alphaAB) {
                        str.append(text);
                        str.append("\n");
                    }
                }
            }
            
            log.setFitParameters(str.toString());
            //log.setFitParameters(" ");
            //log.setImgPath(picpath);
            log.setImgPath(imagePath);
            
            String str_file_header = "";
            for(  Object text : fileHeader )
            {
                str_file_header = str_file_header + text + "\n";
            }
                log.AddAdditionalText(str_file_header);
//log.getRunNumber();                                                                        
            log.addComments();
        }
	
    }
    
    
    public void initButtons(JPanel panel){
        Box vertical = Box.createVerticalBox();
        
        Box boxOF = Box.createHorizontalBox();
        boxOF.add(new JLabel("Choose File : "));
        JButton buttonOpenFile = new JButton("Open File");
        buttonOpenFile.addActionListener(this);
        boxOF.add(buttonOpenFile);
        
        vertical.add(boxOF);
        Box boxFT = Box.createHorizontalBox();
        boxFT.add(new JLabel("Refit Data : "));
        JButton buttonFitData = new JButton("Fit Data");
        buttonFitData.addActionListener(this);
        boxFT.add(buttonFitData);
        vertical.add(boxFT);
        
        Box boxLG = Box.createHorizontalBox();
        boxLG.add(new JLabel("Submit Log : "));        
        JButton buttonLog = new JButton("Log Entry");
        buttonLog.addActionListener(this);
        boxLG.add(buttonLog);
        vertical.add(boxLG);
        
        Box boxWR = Box.createHorizontalBox();
        boxWR.add(new JLabel("Refit Data : "));
       
        comboWire = new JComboBox(counterNames);
        comboWire.setSelectedIndex(5);
        boxWR.add(comboWire);
        vertical.add(boxWR);
        
        Box boxBT = Box.createHorizontalBox();
        JButton buttonView = new JButton("Data View");
        buttonView.addActionListener(this);
        boxBT.add(buttonView);
/*        
        JButton buttonEx = new JButton("Expert");
        buttonEx.addActionListener(this);
        boxBT.add(buttonEx);
  */      
        vertical.add(boxBT);
        panel.add(vertical);
    }
    
    
    public void loadData(String filename){
        DataTable  table = new DataTable();
        table.readFile(filename);
        
        table.show();
       
        fileHeader = table.getHeader();
        this.harpWireToFit = comboWire.getSelectedIndex() + 2;
        System.err.println("SWITHC WIRE TO " + this.harpWireToFit);

	//harpAnalyzer.init(table, 13);
        harpAnalyzer.init(table, harpWireToFit);

        harpAnalyzer.fitData();
        ArrayList<DataSetXY>  harpData = harpAnalyzer.getHarpData();
        int ngraphs = harpData.size();
        System.err.println(" HARP SCAN DATA SIZE = " + ngraphs);
        
        canvas.divide(1, ngraphs);
        canvas.repaint();
        for(int loop =0; loop < ngraphs; loop++){
	    canvas.setLogY(loop,true);
            DataSetXY data = harpData.get(loop);
            //canvas.addPoints(loop, 
            //        data.getDataX().getArray(), 
            //        data.getDataY().getArray(),4);
            canvas.addPoints(loop, 
                    data.getDataX().getArray(), 
                    data.getDataY().getArray(),4,1,4,3);
        }
        
        for(int loop =0; loop < ngraphs; loop++){
            DataSetXY data = harpAnalyzer.getHarpFuncs().get(loop).getDataSet();
            canvas.addLine(loop, 
                    data.getDataX().getArray(), 
                    data.getDataY().getArray(),2);
        }
        
        for(int loop =0; loop < ngraphs; loop++){
            String[] legend = harpAnalyzer.getLegend(loop, this_harp_dir);
            canvas.addLegend(loop, 0.04, 0.02, legend);
        }
        
        if( ngraphs == 3 )
        {
            String[] legend = harpAnalyzer.getLegendAlphaAB(this_harp_dir);
            canvas.addLegend(0, 0.65, 0.05, legend);
        }
        String[] counter_name = {"counter:  " + counterNames[comboWire.getSelectedIndex()]};
        String file_stamp = currentFileName;
        file_stamp = file_stamp.replace(".txt", "");
        String[] str_filename = {file_stamp};
        String[] beam_pos_legend = harpAnalyzer.getBeamXY_legend(this_harp_dir);
        canvas.addLegend(1, 0.6, 0.25, counter_name);
	canvas.addLegend(1, 0.6, 0.15, str_filename);
        canvas.addLegend(2, 0.6, 0.15, beam_pos_legend);
;    }
    
    public void loadData(){
        JFileChooser chooser = new JFileChooser(currentHarpFilesDir);
        FileNameExtensionFilter filter = new FileNameExtensionFilter(
								     "Harp Scan Files", "txt","text");
        chooser.setFileFilter(filter);
        int returnVal = chooser.showOpenDialog(this);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            currentFileName = chooser.getSelectedFile().getName();
            currentFilePath = chooser.getSelectedFile().getAbsolutePath();
            System.out.println("You chose to open this file: " +
                    chooser.getSelectedFile().getName() + 
                    "  " + chooser.getSelectedFile().getAbsolutePath());  
            this.loadData(chooser.getSelectedFile().getAbsolutePath());
        }
    }
    
    public static void main(String[] args){
        
	String harp_dir = args[0];
	        
	System.out.println("harp_dir = " + harp_dir);

	String wireScanType = "HARP_2_WIRE";
        int    nwires       = 3;
        int  windowSizeX = 1200;
        int  windowSizeY =  800;
        int wiretofit    =   4; // Was 13 before

	//System.out.println("The harp_dir = " + this_harp_dir);

        /*
        if(args.length>0){
            windowSizeX = Integer.parseInt(args[0]);
            windowSizeY = Integer.parseInt(args[1]);
            wireScanType = args[2];
            wiretofit    = Integer.parseInt(args[3]);
            
            if(wireScanType.compareTo("HARP_3_WIRE")==0){
                nwires = 3;
            }
            if(wireScanType.compareTo("HARP_2_WIRE")==0){
                nwires = 2;
            }
            if(wireScanType.compareTo("HARP_SVT")==0){
                nwires = 2;
            }
        }*/
        
        double[] limits = new double[nwires*2];
        System.err.println("setting limits for harp scan nargs = " + args.length);
        /*
        int argcount = 4;
        for(int loop = 0; loop < nwires*2; loop++){
            limits[loop] = Double.parseDouble(args[argcount]);
            argcount++;
            System.err.println(loop + "  " + limits[loop]);
        }*/
        
        HarpScanGUIFULL harp = new HarpScanGUIFULL(wireScanType,limits);
	//harp.this_harp_dir = harp_dir;
	harp.setHarpType(harp_dir);
        harp.harpWireToFit = wiretofit;
        harp.setSize(windowSizeX,windowSizeY);
	harp.initializeEnvironment(wireScanType);
	System.out.println("harp.this_harp_dir = " + harp.this_harp_dir);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getActionCommand().compareTo("Open File")==0){
            this.loadData();
        }
        if(e.getActionCommand().compareTo("Fit Data")==0){
            this.loadData(currentFilePath);
        }
 
        if(e.getActionCommand().compareTo("Log Entry")==0){
            this.makeLogEntry();
        }
	
	if(e.getActionCommand().compareTo("Data View")==0){
            DataTable table = new DataTable();
            //table.readFile("/Users/gavalian/Work/Software/Release-6.0/JavaProjects/clasHarpScan/data/harp_tagger_05-16-12.txt");
            //table.readFile("/misc/home/epics/DATA/HARP_SCANS/harp_2c21/harp_2c21_test1.txt");
            table.readFile(currentFilePath);
	    System.out.println("Viewing file " + currentFilePath);
            DataViewDialog dialog = new DataViewDialog(table,2,this.counterNames);
            dialog.setVisible(true);
        }
        //System.err.println("action command = " + e.getActionCommand());
        //this.loadData();
    }
}
