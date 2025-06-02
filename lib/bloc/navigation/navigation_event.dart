abstract class NavigationEvent {}

class NavigationItemSelected extends NavigationEvent {
  final int selectedIndex;
  NavigationItemSelected(this.selectedIndex);
}
