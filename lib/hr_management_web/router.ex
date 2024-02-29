defmodule HrManagementWeb.Router do
  use HrManagementWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HrManagementWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HrManagementWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/attendance_records", AttendanceRecordLive.Index, :index
    live "/attendance_records/new", AttendanceRecordLive.Index, :new
    live "/attendance_records/:id/edit", AttendanceRecordLive.Index, :edit

    live "/attendance_records/:id", AttendanceRecordLive.Show, :show
    live "/attendance_records/:id/show/edit", AttendanceRecordLive.Show, :edit

    live "/leave_requests", LeaveRequestLive.Index, :index
    live "/leave_requests/new", LeaveRequestLive.Index, :new
    live "/leave_requests/:id/edit", LeaveRequestLive.Index, :edit

    live "/leave_requests/:id", LeaveRequestLive.Show, :show
    live "/leave_requests/:id/show/edit", LeaveRequestLive.Show, :edit

    live "/salary_payouts", SalaryPayoutLive.Index, :index
    live "/salary_payouts/new", SalaryPayoutLive.Index, :new
    live "/salary_payouts/:id/edit", SalaryPayoutLive.Index, :edit

    live "/salary_payouts/:id", SalaryPayoutLive.Show, :show
    live "/salary_payouts/:id/show/edit", SalaryPayoutLive.Show, :edit

    live "/performance_reviews", PerformanceReviewLive.Index, :index
    live "/performance_reviews/new", PerformanceReviewLive.Index, :new
    live "/performance_reviews/:id/edit", PerformanceReviewLive.Index, :edit

    live "/performance_reviews/:id", PerformanceReviewLive.Show, :show
    live "/performance_reviews/:id/show/edit", PerformanceReviewLive.Show, :edit

    live "/expense_claims", ExpenseClaimLive.Index, :index
    live "/expense_claims/new", ExpenseClaimLive.Index, :new
    live "/expense_claims/:id/edit", ExpenseClaimLive.Index, :edit

    live "/expense_claims/:id", ExpenseClaimLive.Show, :show
    live "/expense_claims/:id/show/edit", ExpenseClaimLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", HrManagementWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hr_management, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HrManagementWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
