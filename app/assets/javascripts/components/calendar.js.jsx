var Calendar = React.createClass({

    render: function() {
        return (
            <div class="calendar-container">
                <table class="centered">
                    <thead>
                    <tr>
                    <th colspan="2" class="left-align"><span class="previous"><</span></th>
                    <th colspan="3" class="center">September</th>
                    <th colspan="2" class="right-align"><span class="next">></span></th>
                    </tr>
                    <tr>
                    <th>Mon</th>
                    <th>Tue</th>
                    <th>Wed</th>
                    <th>Thu</th>
                    <th>Fri</th>
                    <th>Sat</th>
                    <th>Sun</th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span>1</span></td>
                            <td><span>2</span></td>
                            <td><span>3</span></td>
                            <td><span>4</span></td>
                            <td><span>5</span></td>
                            <td><span>6</span></td>
                            <td><span>7</span></td>
                        </tr>
                        <tr>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle green valign has-event">8</span></td>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">9</span></td>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">10</span></td>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">11</span></td>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle red valign has-event">12</span></td>
                            <td><span>13</span></td>
                            <td><span>14</span></td>
                        </tr>
                        <tr>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">15</span></td>
                            <td><span>16</span></td>
                            <td><span>17</span></td>
                            <td><span>18</span></td>
                            <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">19</span></td>
                            <td><span>20</span></td>
                            <td><span>21</span></td>
                        </tr>
                    <tr>
                    <td><span class="waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">22</span></td>
                    <td><span class="waves-effect hoverable circle valign">23</span></td>
                    <td><span>24</span></td>
                    <td><span>25</span></td>
                    <td><span>26</span></td>
                    <td><span>27</span></td>
                    <td><span>28</span></td>
                    </tr>
                    <tr>
                    <td><span>29</span></td>
                    <td><span>30</span></td>
                    <td><span>31</span></td>
                    <td><span>1</span></td>
                    <td><span>2</span></td>
                    <td><span>3</span></td>
                    <td><span>4</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        );
    }
});
