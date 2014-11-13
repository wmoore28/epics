/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.harp.gui;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.TitledBorder;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.jlab.data.graph.DataTable;


/**
 *
 * @author gavalian
 */
public class ControlsPanel extends JPanel implements ActionListener {
    
    public JButton openFileButton = null;
    public JComboBox wireToFit = new JComboBox();
    public DataTable dataTable = new DataTable();
    
    public ControlsPanel(){
        super();
        TitledBorder titled = new TitledBorder("Controls");
        this.setBorder(titled);
        this.setPreferredSize(new Dimension(500,120));
        this.setLayout(new GridLayout(2,2));
        /*
        * Add open button
        */
        JLabel label = new JLabel("Open File:");
        JPanel opbpanel = new JPanel();
        openFileButton = new JButton("Choose");
        this.add(label);
        opbpanel.add(openFileButton);
        openFileButton.addActionListener(this);
        this.add(opbpanel);
        /*
        * Add combo box
        */
        JLabel label2 = new JLabel("Choose wire:");
        wireToFit = new JComboBox(new String[]{"2","3","4","5","6","7","8"});
        this.add(label2);        
        this.add(wireToFit);        
    }
    
    
    public static void main(String[] args){
        JFrame frame = new JFrame();
        
        ControlsPanel panel = new ControlsPanel();
        frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.PAGE_AXIS));
                frame.pack();
        frame.setSize(600,300);
        frame.add(panel);
        //for(int loop = 0 ; loop < 3 ; loop++)
        frame.pack();
        frame.setVisible(true);
        
    }   

    @Override
    public void actionPerformed(ActionEvent e) {
        System.err.println("action performed");
        JFileChooser chooser = new JFileChooser(".");
        FileNameExtensionFilter filter = new FileNameExtensionFilter(
            "Harp Scan Files", "txt","text");
        chooser.setFileFilter(filter);
        int returnVal = chooser.showOpenDialog(this);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            System.out.println("You chose to open this file: " +
                    chooser.getSelectedFile().getName() + 
                    "  " + chooser.getSelectedFile().getAbsolutePath());
            dataTable.readFile(chooser.getSelectedFile().getAbsolutePath());
            
            /*
            Harp3WireAnalyzer analyzer = new Harp3WireAnalyzer(dataTable,13,
                    new double[]{3.0,20.0,20.0,40.0,40.0,60.0});
            analyzer.fit();
            analyzer.show();
            */
            /*
            Harp2WireAnalyzer analyzer = new Harp2WireAnalyzer(dataTable,13,
                    new double[]{18.0,35.0,35.0,60.0});
            analyzer.fit();
            analyzer.show();
            */
            //System.err.println(dataTable.toString());
            /*
            double[] xcolumn = dataTable.getColumnAsDouble( 0, 0, 3.0, 20.0);
            double[] ycolumn = dataTable.getColumnAsDouble(13, 0, 3.0, 20.0);
            
            double[] xc_wire_2 = dataTable.getColumnAsDouble(0,  0, 20, 40.0);
            double[] yc_wire_2 = dataTable.getColumnAsDouble(13, 0, 20.0,40.0);
            
            double[] xc_wire_3 = dataTable.getColumnAsDouble(0,  0, 40.0, 60.0);
            double[] yc_wire_3 = dataTable.getColumnAsDouble(13, 0, 40.0,60.0);
            
            HarpScanFunction funcWire1 = new HarpScanFunction(xcolumn,ycolumn);
            HarpScanFunction funcWire2 = new HarpScanFunction(xc_wire_2,yc_wire_2);
            HarpScanFunction funcWire3 = new HarpScanFunction(xc_wire_3,yc_wire_3);

            HarpFunctionFitter fitter = new HarpFunctionFitter();
            fitter.fit(funcWire1);
            fitter.fit(funcWire2);
            fitter.fit(funcWire3);
            
            System.err.println(funcWire1.toString());
            System.err.println(funcWire2.toString());
            System.err.println(funcWire3.toString());


            System.err.println("FUNC = " + funcWire3.getMean() + " " + funcWire3.getRMS());
            */
        }
        
    }
}
