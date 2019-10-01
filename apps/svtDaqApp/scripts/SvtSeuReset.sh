echo "Reseting SEUs..." 

caput SVT:daq:fe:0:seu_count 0
caput SVT:daq:fe:1:seu_count 0
caput SVT:daq:fe:2:seu_count 0
caput SVT:daq:fe:3:seu_count 0
caput SVT:daq:fe:4:seu_count 0
caput SVT:daq:fe:5:seu_count 0
caput SVT:daq:fe:6:seu_count 0
caput SVT:daq:fe:7:seu_count 0
caput SVT:daq:fe:8:seu_count 0
caput SVT:daq:fe:9:seu_count 0

caput SVT:daq:fe:0:seu_seen False
caput SVT:daq:fe:1:seu_seen False
caput SVT:daq:fe:2:seu_seen False
caput SVT:daq:fe:3:seu_seen False
caput SVT:daq:fe:4:seu_seen False
caput SVT:daq:fe:5:seu_seen False
caput SVT:daq:fe:6:seu_seen False
caput SVT:daq:fe:7:seu_seen False
caput SVT:daq:fe:8:seu_seen False
caput SVT:daq:fe:9:seu_seen False

echo "SEUs are now reset..."
