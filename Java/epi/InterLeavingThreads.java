  class OddEvenMonitor {

    public static final boolean ODD_TURN = false;
    public static final boolean EVEN_TURN = true;
    private boolean turn = ODD_TURN;

    public synchronized void waitTurn(boolean oldTurn) {
        while (turn != oldTurn) {
          try {
            wait();
          } catch (InterruptedException e) {
              System.out.println("Interrupted Exception in wait()" + e);
          }
        }
    }


    public synchronized void toggleTurn() {
       turn ^= true;
       notify();
    }
}

  class OddThread extends Thread {
   private final OddEvenMonitor monitor;

   public OddThread(OddEvenMonitor monitor) { this.monitor = monitor; }
   @Override
   public void run() {
      for (int ix = 1; ix <= 100; ix+=2) {
         monitor.waitTurn(OddEvenMonitor.ODD_TURN);
         System.out.println("i = " + ix);
         monitor.toggleTurn();
      }
   }
}

  class EvenThread extends Thread {
  private final OddEvenMonitor monitor;

  public EvenThread(OddEvenMonitor monitor) { this.monitor = monitor; }

  @Override
  public void run() {
    for (int jx = 2; jx <= 100; jx+=2) {
        monitor.waitTurn(OddEvenMonitor.EVEN_TURN);
        System.out.println("j = " + jx);
        monitor.toggleTurn();
    }
  }
}

public  class InterLeavingThreads {

public static void main(String[] args) throws InterruptedException {
   OddEvenMonitor monitor = new OddEvenMonitor();
   Thread t1 = new OddThread(monitor);
   Thread t2 = new EvenThread(monitor);
   System.out.println("Starting threads...");
   t1.start();
   t2.start();
   t1.join();
   t2.join();
}
}
